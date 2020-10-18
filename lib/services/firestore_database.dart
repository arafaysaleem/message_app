import 'dart:async';

import 'package:meta/meta.dart';

import 'firestore_path.dart';
import 'firestore_service.dart';

import '../models/conversation.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  final String uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid})
      : assert(uid != null, 'Cannot create FirestoreDatabase with null uid');

  Future<void> addOrUpdateConversation(Conversation conversation) {
    return _service.setData(
      path: FirestorePath.conversation(uid, conversation.sender.number),
      data: conversation.toMap(),
    );
  }

  Future<void> readConversation(Conversation conversation) {
    return _service.documentAction(
      path: FirestorePath.conversation(uid, conversation.sender.number),
      changes: {'isRead': conversation.isRead},
    );
  }

  Future<void> readGroup(Conversation conversation) {
    return _service.documentAction(
      path: FirestorePath.group(uid, conversation.groupID),
      changes: {'isRead': conversation.isRead},
    );
  }

  Future<void> addMessages(Conversation conversation) {
    return _service.documentAction(
      path: FirestorePath.conversation(uid, conversation.sender.number),
      changes: {'messages': conversation.serializeMessages()},
    );
  }

  void toggleArchiveSelectedConversations(List<Conversation> _archivedConvos) {
    _archivedConvos.forEach((convo) {
      _service.documentAction(
        path: FirestorePath.conversation(uid, convo.sender.number),
        changes: {'isArchived': convo.isArchived},
      );
    });
  }

  Future<void> spamSelectedConversation(Conversation _spammedConvo) {
    return _service.documentAction(
      path: FirestorePath.conversation(uid, _spammedConvo.sender.number),
      changes: {'isSpam': _spammedConvo.isSpam},
    );
  }

  Future<void> markAllConversationsRead() {
    return _service.batchActon(
      path: FirestorePath.conversations(uid),
      changes: {'isRead': true},
      queryBuilder: (query) => query
          .where('isSpam', isEqualTo: false)
          .where('isArchived', isEqualTo: false),
    );
  }

  Future<void> deleteConversation(Conversation conversation) {
    return _service.deleteData(
      path: FirestorePath.conversation(uid, conversation.sender.number),
    );
  }

  Future<void> addOrUpdateGroup(Conversation conversation) {
    return _service.setData(
      path: FirestorePath.group(uid, conversation.groupID),
      data: conversation.toMap(),
    );
  }

  Future<void> deleteGroup(Conversation conversation) {
    return _service.deleteData(
      path: FirestorePath.group(uid, conversation.groupID),
    );
  }

  Stream<Conversation> conversationStream({@required String number}) {
    return _service.documentStream(
      path: FirestorePath.conversation(uid, number),
      builder: (data, documentId) => Conversation.fromMap(data),
    );
  }

  Stream<Conversation> groupStream({@required String groupID}) {
    return _service.documentStream(
      path: FirestorePath.group(uid, groupID),
      builder: (data, documentId) => Conversation.fromMap(data),
    );
  }

  /// This method fetches all conversations including spammed and archived
  /// in one list.
  ///
  /// Stream<List<Conversation>> allConversationsStream() =>
  ///     _service.collectionStream(
  ///       path: FirestorePath.conversations(uid),
  ///       builder: (data, _) => Conversation.fromMap(data),
  ///     );

  Stream<List<Conversation>> normalStream() {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.conversations(uid),
      queryBuilder: (query) => query
          .where('isSpam', isEqualTo: false)
          .where('isArchived', isEqualTo: false),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.sender.name.compareTo(lhs.sender.name),
    );
  }

  Stream<List<Conversation>> spammedStream() {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.conversations(uid),
      queryBuilder: (query) => query.where('isSpam', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.sender.name.compareTo(lhs.sender.name),
    );
  }

  Stream<List<Conversation>> archivedStream({Conversation conversation}) {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.conversations(uid),
      queryBuilder: (query) => query.where('isArchived', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.sender.name.compareTo(lhs.sender.name),
    );
  }

  Stream<List<Conversation>> groupsStream({Conversation conversation}) {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.groups(uid),
      queryBuilder: (query) => query.where('isGroup', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.groupName.compareTo(lhs.groupName),
    );
  }
}
