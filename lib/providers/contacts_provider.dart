import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:message_app/models/conversation.dart';

import 'messages_provider.dart';

import '../helper/utils.dart';

import '../models/contact.dart';

class ContactsProvider with ChangeNotifier {
  final MessageManager _messageManager;
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

  ContactsProvider(this._messageManager) {
    _contacts.sort((Contact a, Contact b) => a.name.compareTo(b.name)); //sort while fetching from firebase
  }

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

  void toggleCreateGroupMode(){
    _createGroupActive=!_createGroupActive;
    notifyListeners();
  }

  void unSelectContact(Contact contact) {
    _selectedContacts.remove(contact);
    notifyListeners();
  }

  void selectContact(Contact contact) {
    _selectedContacts.add(contact);
    notifyListeners();
  }

  void toggleSelected(Contact contact) {
    if (isSelected(contact))
      unSelectContact(contact);
    else
      selectContact(contact);
  }

  void clearSelected(){
    _selectedContacts.clear();
    notifyListeners();
  }

  Conversation get getNewGroupConversation => _messageManager.createGroupConversation(selectedContacts);

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
