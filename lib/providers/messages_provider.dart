import 'dart:collection';
import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class MessageManager with ChangeNotifier {
  final Map<int, Conversation> _conversations = {
    03028220488: Conversation(
      sender: Contact(name: "Farhan",number: 03028220488),
      messages: [
        Message(
          number: 03028220488,
          body: "First Message",
          datetime: DateTime.now(),
          previewPath: "hello"
        ),
        Message(
          number: 03028220488,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03028199488: Conversation(
      sender: Contact(name: "Asad",number: 03028199488),
      messages: [
        Message(
          number: 03028199488,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03028199488,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03010220805: Conversation(
      sender: Contact(number: 03010220805),
      messages: [
        Message(
          number: 03010220805,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03010220805,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03009268622: Conversation(
      sender: Contact(name: "Shahzaib",number: 03009268622),
      messages: [
        Message(
          number: 03009268622,
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now().subtract(Duration(days: 2)),
        ),
        Message(
          number: 03009268622,
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now().subtract(Duration(days: 32)),
        ),
        Message(
          number: 03009268622,
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03009219062: Conversation(
      sender: Contact(number: 03009219062, name: "Papa"),
      messages: [
        Message(
          number: 03009219062,
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03009219062,
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03339120488: Conversation(
      sender: Contact(name: "Hamza",number: 03339120488),
      messages: [
        Message(
          number: 03339120488,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03339120488,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03328144588: Conversation(
      sender: Contact(name: "Rafay",number: 03328144588),
      messages: [
        Message(
          number: 03328144588,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03328144588,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03309658505: Conversation(
      sender: Contact(number: 03309658505),
      messages: [
        Message(
          number: 03309658505,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03309658505,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03003528563: Conversation(
      sender: Contact(name: "Zohaib",number: 03003528563),
      messages: [
        Message(
          number: 03003528563,
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03012500876: Conversation(
      sender: Contact(number: 03012500876, name: "Mama"),
      messages: [
        Message(
          number: 03012500876,
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03012500876,
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03024320488: Conversation(
      sender: Contact(number: 03024320488),
      messages: [
        Message(
          number: 03024320488,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03024320488,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03028145488: Conversation(
      sender: Contact(number: 03028145488),
      messages: [
        Message(
          number: 03028145488,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03028145488,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03010656505: Conversation(
      sender: Contact(name: "Suraksha",number: 03010656505),
      messages: [
        Message(
          number: 03010656505,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03010656505,
          body: "Milk my tits ( . )( . ). They are waiting for you :*."
              "Daba daba ke doodh nikaldo inka chooso zor se phaar do mere"
              "mammay bhenchod.",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03009565352: Conversation(
      sender: Contact(name: "Bakhtyar Bellcow",number: 03009565352),
      messages: [
        Message(
          number: 03009565352,
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03009756562: Conversation(
      sender: Contact(number: 03009756562, name: "Meeran"),
      messages: [
        Message(
          number: 03009756562,
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03009756562,
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03339657568: Conversation(
      sender: Contact(number: 03339657568),
      messages: [
        Message(
          number: 03339657568,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03339657568,
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03328652868: Conversation(
      sender: Contact(name: "Bakh Randi<3",number: 03328652868),
      messages: [
        Message(
          number: 03328652868,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03328652868,
          body: "Mere mammay chooso janu (.)(.). Muaah :*",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03309677784: Conversation(
      sender: Contact(name: "Faryal Janu<3",number: 03309677784),
      messages: [
        Message(
          number: 03309677784,
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03309677784,
          body: "Zor se chodo mujhe baby. Mujhe tumhara lund chahiye",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03003768643: Conversation(
      sender: Contact(name: "Faryal Shaikh",number: 03003768643),
      messages: [
        Message(
          number: 03003768643,
          body: "I want you to suck on my big tits!"
              " Press them, squeeze the juicy hell out of them. Slap your balls against my soft ass and"
              " finger my choot jab tak pani na nikal jaye. Muaah :* ?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    03012668889: Conversation(
      sender: Contact(number: 03012668889, name: "Zain"),
      messages: [
        Message(
          number: 03012668889,
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: 03012668889,
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
  };
  final List<Conversation> _selectedConversations = [];
  final List<Message> _favMessages = [];
  final List<Conversation> _spammedConversations = [];
  final List<Conversation> _archivedConversations = [];
  final List<Contact> _contacts = [];

  UnmodifiableMapView<int, Conversation> get conversationsMap =>
      UnmodifiableMapView(_conversations);

  UnmodifiableListView<Conversation> get conversations =>
      UnmodifiableListView(_conversations.values);

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  UnmodifiableListView<Conversation> get selectedConversations =>
      UnmodifiableListView(_selectedConversations);

  UnmodifiableListView<Message> get favMsgs => UnmodifiableListView(_favMessages);

  UnmodifiableListView<Conversation> get spammedConversations =>
      UnmodifiableListView(_spammedConversations);

  UnmodifiableListView<Conversation> get archivedConversations =>
      UnmodifiableListView(_archivedConversations);

  Contact getSenderContact(int number) {
    Contact sender = Contact(number: number);
    if (_contacts.contains(sender))
      return _contacts
          .where((Contact contact) => contact == sender)
          .toList()[0];
    return sender;
  } //call from api helper

  bool isSelected(Conversation convo) => _selectedConversations.contains(convo);

  void readAllConversations() {
    _conversations.values.forEach((Conversation convo) => convo.readConversation());
  }

  void deleteConversation(Conversation convo) {
    _conversations.removeWhere((number, converse) => number == convo.sender.number);
  }

  void deleteSelected() {
    _selectedConversations.forEach((Conversation convo) => deleteConversation(convo));
    clearSelected();
  }

  void clearSelected(){
    _selectedConversations.clear();
    notifyListeners();
  }

  void archiveSelected() {
    _selectedConversations.forEach((Conversation convo) {
      if (convo.isArchived) {
        _conversations[convo.sender.number] = convo;
        _archivedConversations.remove(convo);
      } else {
        _conversations
            .removeWhere((number, converse) => number == convo.sender.number);
        _archivedConversations.add(convo);
      }
      convo.toggleArchived();
      print(convo);
    });
    print(_archivedConversations);
    clearSelected();
  }

  void spamSelected() {
    toggleSpamConvo(_selectedConversations[0]); //bcz only one can be spammed
  }

  void unSelectConversation(Conversation convo) {
    _selectedConversations.remove(convo);
    notifyListeners();
  }

  void selectConversation(Conversation convo) {
    _selectedConversations.add(convo);
    notifyListeners();
  }

  void toggleSelected(Conversation convo) {
    if (isSelected(convo))
      unSelectConversation(convo);
    else
      selectConversation(convo);
  }

  void toggleArchiveConvo(Conversation convo) {
    if (convo.isArchived) {
      _conversations[convo.sender.number] = convo;
      _archivedConversations.remove(convo);
    } else {
      _conversations
          .removeWhere((number, converse) => number == convo.sender.number);
      _archivedConversations.add(convo);
    }
    convo.toggleArchived();
    notifyListeners();
  }

  void toggleSpamConvo(Conversation convo) {
    if (convo.isSpam) {
      _conversations[convo.sender.number] = convo;
      _spammedConversations.remove(convo);
    } else {
      _conversations
          .removeWhere((number, converse) => number == convo.sender.number);
      _spammedConversations.add(convo);
    }
    convo.toggleSpam();
    print(convo);
    print(_spammedConversations);
    clearSelected();
  }

  void toggleFavMessage(Message msg) {
    if (msg.isFav)
      _favMessages.remove(msg);
    else
      _favMessages.add(msg);
    msg.isFav = !msg.isFav;
    notifyListeners();
  }

}
