import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import '../services/firestore_database.dart';

import '../models/contact.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class MessageManager with ChangeNotifier {
  final FirestoreDatabase _firestoredb;

  MessageManager({@required firestoredb}) : _firestoredb = firestoredb {
    _initializeData();
  }

  //initialise with firestore
  final Map<String, Conversation> _conversations = Map();
  final Map<String, Conversation> _groups = Map();
  List<Conversation> _spammedConversations = [];
  List<Conversation> _archivedConversations = [];

  //TODO: Delete these comments after app done
  /*final Map<String, Conversation> _conversations = {
    "03028220488": Conversation(
      sender: Contact(name: "Farhan",number: "03028220488",avClr: Colors.red),
      messages: [
        Message(
          number: "03028220488",
          body: "First Message",
          datetime: DateTime.now(),
          previewPath: "hello"
        ),
        Message(
          number: "03028220488",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03028199488": Conversation(
      sender: Contact(name: "Asad",number: "03028199488",avClr: Colors.blue),
      messages: [
        Message(
          number: "03028199488",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03028199488",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03010220805": Conversation(
      sender: Contact(number: "03010220805",avClr: Colors.red),
      messages: [
        Message(
          number: "03010220805",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03010220805",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03009268622": Conversation(
      sender: Contact(name: "Shahzaib",number: "03009268622",avClr: Colors.red),
      messages: [
        Message(
          number: "03009268622",
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now().subtract(Duration(days: 2)),
        ),
        Message(
          number: "03009268622",
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now().subtract(Duration(days: 32)),
        ),
        Message(
          number: "03009268622",
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03009219062": Conversation(
      sender: Contact(number: "03009219062", name: "Papa",avClr: Colors.lightGreenAccent),
      messages: [
        Message(
          number: "03009219062",
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03009219062",
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03339120488": Conversation(
      sender: Contact(name: "Hamza",number: "03339120488",avClr: Colors.amber),
      messages: [
        Message(
          number: "03339120488",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03339120488",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03328144588": Conversation(
      sender: Contact(name: "Rafay",number: "03328144588",avClr: Colors.blue),
      messages: [
        Message(
          number: "03328144588",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03328144588",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03309658505": Conversation(
      sender: Contact(number: "03309658505",avClr: Colors.red),
      messages: [
        Message(
          number: "03309658505",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03309658505",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03003528563": Conversation(
      sender: Contact(name: "Zohaib",number: "03003528563",avClr: Colors.lightGreenAccent),
      messages: [
        Message(
          number: "03003528563",
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03012500876": Conversation(
      sender: Contact(number: "03012500876", name: "Mama",avClr: Colors.red),
      messages: [
        Message(
          number: "03012500876",
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03012500876",
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03024320488": Conversation(
      sender: Contact(number: "03024320488",avClr: Colors.amber),
      messages: [
        Message(
          number: "03024320488",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03024320488",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03028145488": Conversation(
      sender: Contact(number: "03028145488",avClr: Colors.lightGreenAccent),
      messages: [
        Message(
          number: "03028145488",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03028145488",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03010656505": Conversation(
      sender: Contact(name: "Suraksha",number: "03010656505",avClr: Colors.blue),
      messages: [
        Message(
          number: "03010656505",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03010656505",
          body: "Hello did you get the printed mugs?"
              "I saw a page on instagram called allthatjazz.com,"
              "order there.",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03009565352": Conversation(
      sender: Contact(name: "Bakhtyar Bellcow",number: "03009565352",avClr: Colors.red),
      messages: [
        Message(
          number: "03009565352",
          body: "Hi, Rafay! This is Bakhtyar from BellCow Communications."
              " I hope you're fine. I wanted to talk to you regarding our invoicing"
              " options as well as your marketing timeline proposal. What time can we have the meeting?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03009756562": Conversation(
      sender: Contact(number: "03009756562", name: "Meeran",avClr: Colors.blue),
      messages: [
        Message(
          number: "03009756562",
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03009756562",
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03339657568": Conversation(
      sender: Contact(number: "03339657568",avClr: Colors.red),
      messages: [
        Message(
          number: "03339657568",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03339657568",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03328652868": Conversation(
      sender: Contact(name: "Bakh",number: "03328652868",avClr: Colors.blue),
      messages: [
        Message(
          number: "03328652868",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03328652868",
          body: "Flight is gonna reach at 2am",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03309677784": Conversation(
      sender: Contact(name: "Faryal",number: "03309677784",avClr: Colors.blue),
      messages: [
        Message(
          number: "03309677784",
          body: "First Message",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03309677784",
          body: "Check the timetable and update when free",
          datetime: DateTime.now(),
        ),
      ],
    ),
    "03012668889": Conversation(
      sender: Contact(number: "03012668889", name: "Zain",avClr: Colors.amber),
      messages: [
        Message(
          number: "03012668889",
          body: "Where are u ??",
          datetime: DateTime.now(),
        ),
        Message(
          number: "03012668889",
          body: "What time you'll come home?",
          datetime: DateTime.now(),
        ),
      ],
    ),
  };
  final Map<String, Conversation> _groups = {
    "echo1":Conversation(
      sender: Contact(name: "Farhan",number: "03028220488",avClr: Colors.red),
      groupID: "echo1",
      messages: <Message>[
        Message(
            number: "03028220488",
            body: "First Message",
            datetime: DateTime.now(),
            previewPath: "hello"
        ),
        Message(
          number: "03028220488",
          body: "Second Message",
          datetime: DateTime.now(),
        ),
      ],
      groupName: "BOYS",
      isGroup: true,
      participants: <Contact>[
        Contact(name: "Asad",number: "03028199488",avClr: Colors.blue)
      ]
    )
  };*/
  // final List<Conversation> _spammedConversations = [];
  // final List<Conversation> _archivedConversations = [];

  //reset on app start
  final List<Conversation> _selectedConversations = [];
  final List<Message> _favMessages = [];
  bool _displayGroupConversations = false;

  bool get displayGroupConversations => _displayGroupConversations;

  UnmodifiableMapView<String, Conversation> get conversationsMap =>
      UnmodifiableMapView(_conversations);

  UnmodifiableListView<Conversation> get conversations =>
      UnmodifiableListView(_conversations.values);

  UnmodifiableListView<Conversation> get selectedConversations =>
      UnmodifiableListView(_selectedConversations);

  UnmodifiableListView<Message> get favMsgs =>
      UnmodifiableListView(_favMessages);

  UnmodifiableListView<Conversation> get spammedConversations =>
      UnmodifiableListView(_spammedConversations);

  UnmodifiableListView<Conversation> get archivedConversations =>
      UnmodifiableListView(_archivedConversations);

  UnmodifiableMapView<String, Conversation> get groupsMap =>
      UnmodifiableMapView(_groups);

  UnmodifiableListView<Conversation> get groupsConversations =>
      UnmodifiableListView(_groups.values);

  //TODO: Delete these comments after app done
  // void addAllToFirebase(){ //only use this to add convos to firebase
  //   conversations.forEach(_firestoredb.addOrUpdateConversation);
  // }
  //
  // void addGroupsToFirebase(){ //only use this to add groups to firebase
  //   groupsConversations.forEach(_firestoredb.addOrUpdateGroup);
  // }

  void _initializeData() {
    _initializeConversationsMap();
    _initializeSpammedConversations();
    _initializeArchivedConversations();
    _initializeGroupsMap();
  }

  /// Stream based methods
  void _initializeGroupsMap() =>
      _firestoredb.normalGroupsStream().listen((tempGroups) {
        tempGroups.forEach((group) => _groups[group.groupID] = group);
        notifyListeners();
      });

  void _initializeConversationsMap() =>
      _firestoredb.normalStream().listen((tempConversations) {
        tempConversations
            .forEach((convo) => _conversations[convo.sender.number] = convo);
        notifyListeners();
      });

  void _initializeSpammedConversations() =>
      _firestoredb.spammedStream().listen((spammedConvos) {
        _spammedConversations = spammedConvos;
        notifyListeners();
      });

  void _initializeArchivedConversations() =>
      _firestoredb.archivedStream().listen((archivedConvos) {
        _archivedConversations = archivedConvos;
        notifyListeners();
      });

  void toggleDisplayGroupConvos() {
    _displayGroupConversations = !displayGroupConversations;
    notifyListeners();
  }

  void updateConversionList(Conversation convo) {
    if(convo.isGroup){
      _groups.remove(convo.groupID); //remove
      _groups[convo.groupID] = convo; //and insert at end to make it appear on top
      _firestoredb.addOrUpdateGroup(_groups[convo.groupID]);
    }
    else{
    _conversations.remove(convo.sender.number); //remove
    _conversations[convo.sender.number] = convo; //and insert at end to make it appear on top
    _firestoredb.addOrUpdateConversation(_conversations[convo.sender.number]);
    }
    notifyListeners();
  }

  bool isSelected(Conversation convo) => _selectedConversations.contains(convo);

  void sendConversationMessages(
      {@required Conversation convo, @required String text}) {
    convo.sendMessage(text: text);
    _firestoredb.addMessages(convo);
  }

  void readConversation(Conversation convo) {
    if(convo.isRead) return;
    convo.readConversation();
    _firestoredb.readConversation(convo);
  }

  void readGroup(Conversation convo) {
    if(convo.isRead) return;
    convo.readConversation();
    _firestoredb.readGroup(convo);
  }

  void readAllConversations() {
    _conversations.values
        .forEach((Conversation convo) => convo.readConversation());
    _firestoredb.markAllConversationsRead();
  }

  Conversation getConversation(Contact contact) {
    return _conversations[contact.number] ?? _createConversation(contact);
  }

  Conversation createGroupConversation(groupMembers, groupName) {
    Random random = Random();
    String groupID = random.nextInt(100000).toString();
    _groups[groupID] = Conversation(
      sender: groupMembers[0],
      messages: <Message>[],
      isGroup: groupMembers == null ? false : true,
      groupID: groupID,
      groupName: groupName,
      participants: groupMembers,
    );
    _firestoredb.addOrUpdateGroup(_groups[groupID]);
    print(_conversations);
    return _groups[groupID];
  }

  Conversation _createConversation(Contact contact) {
    _conversations[contact.number] = Conversation(
      sender: contact,
      messages: <Message>[],
    );
    _firestoredb.addOrUpdateConversation(_conversations[contact.number]);
    return _conversations[contact.number];
  }

  void deleteConversation(Conversation convo) {
    if (_conversations.containsKey(convo.sender.number))
      _conversations.remove(convo.sender.number);
    else if (_archivedConversations.contains(convo))
      _archivedConversations.remove(convo);
    else if (_spammedConversations.contains(convo))
      _spammedConversations.remove(convo);
    _firestoredb.deleteConversation(convo);
    notifyListeners();
  }

  void deleteGroup(Conversation convo) {
    if (_groups.containsKey(convo.groupID)) _groups.remove(convo.groupID);
    //TODO: add support for group archiving and spamming
    // else if(_archivedGroups.contains(convo)) _archivedGroups.remove(convo);
    // else if(_spammedGroups.contains(convo)) _spammedGroups.remove(convo);
    _firestoredb.deleteGroup(convo);
    notifyListeners();
  }

  void deleteSelected() {
    _selectedConversations
        .forEach((Conversation convo) => deleteConversation(convo));
    clearSelected();
  }

  void clearSelected() {
    _selectedConversations.clear();
    notifyListeners();
  }

  void archiveSelected() {
    _selectedConversations.forEach((Conversation convo) {
      if (convo.isArchived) {
        _archivedConversations.remove(convo);
        _conversations[convo.sender.number] = convo;
      } else {
        _conversations
            .removeWhere((number, converse) => number == convo.sender.number);
        _archivedConversations.add(convo);
      }
      convo.toggleArchived();
    });
    _firestoredb.toggleArchiveSelectedConversations(_selectedConversations);
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
      _archivedConversations.remove(convo);
      _conversations[convo.sender.number] = convo;
    } else {
      _conversations
          .removeWhere((number, converse) => number == convo.sender.number);
      _archivedConversations.add(convo);
    }
    convo.toggleArchived();
    _firestoredb.toggleArchiveSelectedConversations([convo]);
    notifyListeners();
  }

  void toggleSpamConvo(Conversation convo) {
    if (convo.isSpam) {
      _spammedConversations.remove(convo);
      _conversations[convo.sender.number] = convo;
    } else {
      _conversations
          .removeWhere((number, converse) => number == convo.sender.number);
      _spammedConversations.add(convo);
    }
    convo.toggleSpam();
    //TODO: _firestoredb.spamSelectedConversation(convo);
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
