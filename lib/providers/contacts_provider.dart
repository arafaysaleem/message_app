import 'dart:collection';

import 'package:flutter/material.dart';

import '../services/firestore_database.dart';

import 'messages_provider.dart';

import '../helper/utils.dart';

import '../models/conversation.dart';
import '../models/contact.dart';

class ContactsProvider with ChangeNotifier {
  // TODO: Add firestore support to store and sync contacts
  final _firestoredb = FirestoreDatabase.instance;

  final MessageManager _messageManager;

  ContactsProvider(this._messageManager) {
    _contacts.sort((Contact a, Contact b) => a.name.compareTo(b.name)); //sort while fetching from firebase
  }

  final List<Contact> _contacts = [
    Contact(name: "Bakh", number: "03328652868", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.purpleAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.purpleAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.purpleAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
    Contact(name: "Zara", number: "03059346665", avClr: Colors.purpleAccent),
  ];

  final List<Contact> _selectedContacts = [];
  bool _createGroupActive=false;
  bool _addMemberActive=false;

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  UnmodifiableListView<Contact> get top8Contacts {
    final convos=_messageManager.conversations;
    final List<Contact> last8Convos=[];
    for(int i=convos.length-1;i>0;i--){
      if(convos[i].sender.isAdded) last8Convos.add(convos[i].sender);
      if(last8Convos.length == 8) break;
    }
    return UnmodifiableListView(last8Convos);
  }

  UnmodifiableListView<Contact> get selectedContacts =>
      UnmodifiableListView(_selectedContacts);

  bool isSelected(Contact contact) => _selectedContacts.contains(contact);

  bool get createGroupActive => _createGroupActive;

  bool get addMemberActive => _addMemberActive;

  void toggleCreateGroupMode(){
    _createGroupActive=!_createGroupActive;
    notifyListeners();
  }

  void setAddMemberMode(bool flag) => _addMemberActive=flag;

  void _unSelectContact(Contact contact) {
    _selectedContacts.remove(contact);
    notifyListeners();
  }

  void _selectContact(Contact contact) {
    _selectedContacts.add(contact);
    notifyListeners();
  }

  void toggleSelected(Contact contact) {
    if (isSelected(contact))
      _unSelectContact(contact);
    else
      _selectContact(contact);
  }

  void clearSelected(){
    _selectedContacts.clear();
    notifyListeners();
  }

  Conversation createNewGroupConversation(String groupName) {
    return _messageManager.createGroupConversation(selectedContacts,groupName.isNotEmpty ? groupName : "DEFAULT");
  }

  void addParticipant(Conversation convo){
    convo.addParticipant(_selectedContacts);
    _firestoredb.addOrUpdateGroup(convo,merge: true);
    setAddMemberMode(false);
    clearSelected();
  }

  Contact getSenderContact(String number) {
    return _contacts.firstWhere(
          (Contact contact) => contact.number == number,
      orElse: () => Contact(number: number, avClr: Utils.getAvatarColor()),
    );
  } //call from api helper

  UnmodifiableListView<Contact> getFilteredContacts(String text) {
    if (text.isEmpty) {
      return contacts;
    }
    String search = text.toLowerCase();
    List<Contact> filteredContacts = [];
    contacts
        .forEach((contact) {
      if (contact.name.toLowerCase().startsWith(search)) {
        filteredContacts.add(contact);
      }
    });
    return UnmodifiableListView(filteredContacts);
  }
}
