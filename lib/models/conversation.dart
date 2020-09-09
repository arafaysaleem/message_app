import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'contact.dart';
import 'message.dart';

class Conversation with ChangeNotifier{
  static Contact myContact=Contact(number: 03001234567,name: "Abdur Rafay Saleem");
  final Contact sender;
  final List<Message> _messages;
  bool _isRead=false;
  bool _isSpam=false;
  bool _isArchived=false;

  Conversation({@required this.sender,@required messages}) : assert(messages.length >= 1), _messages=messages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Conversation &&
          runtimeType == other.runtimeType &&
          sender == other.sender &&
          _isRead == other.isRead;

  @override
  int get hashCode => sender.hashCode ^ _isRead.hashCode;

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);

  Message get latestMessage => _messages.last;

  bool get isRead => _isRead;

  bool get isSpam => _isSpam;

  bool get isArchived => _isArchived;

  void addMessage(Message msg) { //for incoming messages
    _messages.add(msg);
    notifyListeners();
  }

  void sendMessage({@required String text,previewAsset}){ //for sending messages
    _messages.add(Message(body: text.trim(),datetime: DateTime.now(),previewPath: previewAsset,number: myContact.number));
    notifyListeners();
  }

  void editMyContact({String name,int number, String picPath}){
    myContact=Contact(name: name??myContact.name,number: number??myContact.number,picturePath: picPath??myContact.picturePath);
    notifyListeners();
  }

  void deleteMessage(Message msg){
    _messages.remove(msg);
    notifyListeners();
  }

  void toggleSpam(){
    _isSpam=!_isSpam;
    notifyListeners();
  }

  void toggleArchived(){
    _isArchived=!_isArchived;
  }

  void readConversation(){
    if(!_isRead) _isRead=true;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Conversation{sender: $sender, _isRead: $_isRead}';
  }
}