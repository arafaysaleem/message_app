import 'dart:collection';

import 'package:flutter/material.dart';

import '../services/firestore_database.dart';

import 'messages_provider.dart';

import '../models/conversation.dart';
import '../models/contact.dart';

class ContactsProvider with ChangeNotifier {

  /// Instance of firestore database
  FirestoreDatabase _firestoredb = FirestoreDatabase.instance;

  /// Instance of messages provider
  MessagesProvider _messagesProvider;

  /// Initializes and loads the contacts for the logged in user
  init(){
    _initializeDefaults();
    _initializeData();
  }

  //initialise with firestore
  List<Contact> _contacts;
  List<Contact> _selectedContacts;
  bool _createGroupActive;
  bool _addMemberActive;

  /// Internal method to initialize all variables for the logged in user
  void _initializeDefaults(){
    _contacts = [];
    _selectedContacts = [];
    _createGroupActive = false;
    _addMemberActive = false;
  }

  /// Internal method to load all contacts for logged in user
  void _initializeData() {
    _firestoredb.contactsStream().listen((contacts) {
      _contacts = contacts;
      notifyListeners();
    });
  }

  /// Method to initialize messages provider for logged in user
  void update(MessagesProvider messageManager) {
    _messagesProvider = messageManager;
  }

  /// Returns an unmodifiable list of all contacts
  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  /// Returns an unmodifiable list of top 8 contacts
  UnmodifiableListView<Contact> get top8Contacts {
    final convos = _messagesProvider.conversations;
    final List<Contact> last8Convos = [];
    for (int i = convos.length - 1; i > 0; i--) {
      if (convos[i].sender.isAdded) last8Convos.add(convos[i].sender);
      if (last8Convos.length == 8) break;
    }
    return UnmodifiableListView(last8Convos);
  }

  /// Returns an unmodifiable list of selected contacts
  UnmodifiableListView<Contact> get selectedContacts =>
      UnmodifiableListView(_selectedContacts);

  /// Returns an unmodifiable list of filtered contacts matching search text
  UnmodifiableListView<Contact> getFilteredContacts(String text) {
    if (text.isEmpty) {
      return contacts;
    }
    String search = text.toLowerCase();
    List<Contact> filteredContacts = [];
    contacts.forEach((contact) {
      if (contact.name.toLowerCase().startsWith(search)) {
        filteredContacts.add(contact);
      }
    });
    return UnmodifiableListView(filteredContacts);
  }

  /// Returns true if a contact is selected
  bool isSelected(Contact contact) => _selectedContacts.contains(contact);

  /// Returns true if new group is being created
  bool get createGroupActive => _createGroupActive;

  /// Returns true if a new member is being added
  bool get addMemberActive => _addMemberActive;

  /// Toggles new group mode
  void toggleCreateGroupMode() {
    _createGroupActive = !_createGroupActive;
    notifyListeners();
  }

  /// Toggles new member mode
  void setAddMemberMode(bool flag) => _addMemberActive = flag;

  /// Selects/unselects a contact
  void toggleSelected(Contact contact) {
    if (isSelected(contact)) _selectedContacts.remove(contact);
    else _selectedContacts.add(contact);
    notifyListeners();
  }

  /// Unselects all contacts
  void clearSelected() {
    _selectedContacts.clear();
    notifyListeners();
  }

  /// Creates and returns a new group conversation with the specified name
  Conversation createNewGroupConversation(String groupName) {
    return _messagesProvider.createGroupConversation(
        selectedContacts, groupName.isNotEmpty ? groupName : "DEFAULT");
  }

  /// Adds a new participant to a conversation and updates the database
  void addParticipant(Conversation convo) {
    convo.addParticipant(_selectedContacts);
    _firestoredb.addOrUpdateGroup(convo, merge: true);
    setAddMemberMode(false);
    clearSelected();
  }

  /// Sets the name for a contact and updates the database
  void addContact(Conversation convo,String name){
    convo.sender.setName(name);
    _contacts.add(convo.sender);
    _firestoredb.addOrUpdateContact(convo.sender);
    _firestoredb.addOrUpdateConversation(convo, merge: true);
    convo.notifyListeners();
  }
}
