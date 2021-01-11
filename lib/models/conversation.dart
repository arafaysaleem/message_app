import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helper/enums/conversation_type_enum.dart';

import 'contact.dart';
import 'message.dart';

class Conversation with ChangeNotifier {
  static Contact myContact = Contact(
      number: "03001234567", name: "Abdur Rafay Saleem", avClr: Colors.red);
  final Contact sender;
  final List<Message> _messages;
  List<Contact> _participants;
  bool _isRead;
  bool _isSpam;
  bool _isGroup;
  final String _groupID;
  String _groupName;
  bool _isArchived;

  Conversation({
    participants,
    @required this.sender,
    @required messages,
    isGroup = false,
    groupID,
    groupName,
    bool isRead = false,
    bool isSpam = false,
    bool isArchived = false,
  })  : assert(messages.length >= 0, "No. of messages can't be less than 0"),
        assert(!isGroup ||
            (participants != null && groupID != null && groupName != null)),
        _messages = messages,
        _isGroup = isGroup,
        _participants = participants ?? [],
        _groupID = groupID,
        _isRead = isRead,
        _isSpam = isSpam,
        _isArchived = isArchived,
        _groupName = groupName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Conversation &&
          runtimeType == other.runtimeType &&
          sender == other.sender &&
          _isRead == other.isRead;

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return new Conversation(
      sender: Contact.fromMap(map['sender']),
      messages: deserializeMessages(map['messages']),
      participants: deserializeParticipants(map['participants']),
      isRead: map['isRead'] as bool,
      isSpam: map['isSpam'] as bool,
      isGroup: map['isGroup'] as bool,
      groupID: map['groupID'] as String,
      groupName: map['groupName'] as String,
      isArchived: map['isArchived'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': this.sender.toMap(),
      'messages': serializeMessages(),
      'participants': serializeParticipants(),
      'isRead': this._isRead,
      'isSpam': this._isSpam,
      'isGroup': this._isGroup,
      'groupID': this._groupID,
      'groupName': this._groupName,
      'isArchived': this._isArchived,
    };
  }

  @override
  int get hashCode => sender.hashCode ^ _isRead.hashCode;

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);

  UnmodifiableListView<Contact> get participants =>
      UnmodifiableListView(_participants);

  Message get latestMessage => _messages.last;

  bool get isRead => _isRead;

  bool get isSpam => _isSpam;

  String get groupID => _groupID;

  String get groupName => _groupName;

  bool get isArchived => _isArchived;

  bool get isGroup => _isGroup;

  serializeMessages() {
    return _messages.map((msg) => msg.toMap()).toList();
  }

  static List<Message> deserializeMessages(msgs) =>
      msgs.map((msg) => Message.fromMap(msg)).toList().cast<Message>();

  serializeParticipants() {
    return _participants.map((contact) => contact.toMap()).toList();
  }

  static List<Contact> deserializeParticipants(members) => members
      .map((contact) => Contact.fromMap(contact))
      .toList()
      .cast<Contact>();

  ConversationType get conversationType {
    if (_isArchived)
      return ConversationType.ARCHIVED;
    else if (_isSpam) return ConversationType.SPAMMED;
    return ConversationType.NORMAL;
  }

  void addParticipant(List<Contact> _participants) {
    if (!_isGroup) _isGroup = true;
    this._participants = _participants;
  }

  void addMessage(Message msg) {
    //for incoming messages
    _messages.add(msg);
    notifyListeners();
  }

  void sendMessage({@required String text, @required previewAsset}) {
    //for sending messages
    _messages.add(
      Message(
        body: text.trim(),
        datetime: DateTime.now(),
        previewPath: previewAsset,
        number: myContact.number,
      ),
    );
    notifyListeners();
  }

  void editMyContact({String name, int number, String picPath}) {
    myContact = Contact(
        avClr: myContact.avClr,
        name: name ?? myContact.name,
        number: number ?? myContact.number,
        picturePath: picPath ?? myContact.picturePath);
    notifyListeners();
  }

  void deleteMessage(Message msg) {
    _messages.remove(msg);
    notifyListeners();
  }

  void toggleSpam() {
    _isSpam = !_isSpam;
    notifyListeners();
  }

  void toggleArchived() {
    _isArchived = !_isArchived;
  }

  void readConversation() {
    if (_isRead) return;
    _isRead = true;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Conversation{sender: $sender, _isRead: $_isRead}';
  }
}
