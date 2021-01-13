import 'dart:async';

import 'package:message_app/models/contact.dart';
import 'package:meta/meta.dart';

import 'firestore_path.dart';
import 'firestore_service.dart';

import '../models/conversation.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  final String uid;
  final _service = FirestoreService.instance;

  // TODO: Add firebase auth, get uid from authUser
  /// Singleton instance of a firestoreDatabase class.
  static final instance = FirestoreDatabase(uid: "Rafay123");

  FirestoreDatabase({@required this.uid})
      : assert(uid != null, 'Cannot create FirestoreDatabase with null uid');

  /// Updates an entire conversation document or adds it if it doesn't exist.
  /// Setting merge to true would only update the document with the new changes
  /// instead of re writing all field.
  Future<void> addOrUpdateConversation(Conversation conversation) {
    return _service.setData(
      path: FirestorePath.conversation(uid, conversation.sender.number),
      data: conversation.toMap(),
    );
  }

  /*
  * Most of the below specified methods for document action can be removed
  * and all the work can be done by addOrUpdate method by specifying merge true. However, you won't have
  * control over what's being updated and to what value it is being updated.final
  */

  /// Sets the conversation isRead to true.
  /// Updates only the specific isRead field instead of updating
  /// the whole document
  Future<void> readConversation(Conversation conversation) {
    return _service.documentAction(
      path: FirestorePath.conversation(uid, conversation.sender.number),
      changes: {'isRead': conversation.isRead},
    );
  }

  /// Sets the group isRead to true.
  /// Updates only the specific isRead field instead of updating
  /// the whole document
  Future<void> readGroup(Conversation conversation) {
    return _service.documentAction(
      path: FirestorePath.group(uid, conversation.groupID),
      changes: {'isRead': conversation.isRead},
    );
  }

  /// Updates the messages list for a conversation to add the new
  /// messages. Updates only the specific messages field instead of updating
  /// the whole document.
  /// Calls the serialiseMessages() method to convert messages to a map.
  Future<void> addMessages(Conversation conversation) {
    return _service.documentAction(
      path: FirestorePath.conversation(uid, conversation.sender.number),
      changes: {'messages': conversation.serializeMessages()},
    );
  }

  /// Iterates over the conversations list to toggle the isArchived field.
  /// Updates only the specific isArchived field instead of updating
  /// the whole document.
  void toggleArchiveSelectedConversations(List<Conversation> archivedConvos) {
    archivedConvos.forEach((convo) {
      print("${convo.isArchived}\t${convo.sender}");
      _service.documentAction(
        path: FirestorePath.conversation(uid, convo.sender.number),
        changes: {'isArchived': convo.isArchived},
      );
    });
  }

  /// Iterates over the groups list to toggle the isArchived field.
  /// Updates only the specific isArchived field instead of updating
  /// the whole document.
  void toggleArchiveSelectedGroups(List<Conversation> archivedGroups) {
    archivedGroups.forEach((group) {
      print("${group.isArchived}\t${group.groupID}\t${group.groupName}");
      _service.documentAction(
        path: FirestorePath.group(uid, group.groupID),
        changes: {'isArchived': group.isArchived},
      );
    });
  }

  /// Sets the isSpam field for the conversation.
  /// Updates only the specific isSpam field instead of updating
  /// the whole document.
  Future<void> spamSelectedConversation(Conversation spammedConvo) {
    print("Spam: ${spammedConvo.sender}");
    return _service.documentAction(
      path: FirestorePath.conversation(uid, spammedConvo.sender.number),
      changes: {'isSpam': spammedConvo.isSpam},
    );
  }

  /// Sets the isSpam field for the group.
  /// Updates only the specific isSpam field instead of updating
  /// the whole document.
  Future<void> spamSelectedGroup(Conversation spammedGroup) {
    print("Spam: ${spammedGroup.groupID}, ${spammedGroup.groupName}");
    return _service.documentAction(
      path: FirestorePath.group(uid, spammedGroup.groupID),
      changes: {'isSpam': spammedGroup.isSpam},
    );
  }

  /// Sets the isBlocked field for the contact.
  /// Updates only the specific isBlocked field instead of updating
  /// the whole document.
  Future<void> blockSelectedContact(Contact blockedContact) {
    print("Block: $blockedContact");
    return _service.documentAction(
      path: FirestorePath.contact(uid, blockedContact.number),
      changes: {'isBlocked': blockedContact.isBlocked},
    );
  }

  /// Performs a batchAction to perform the provided changes on all
  /// the documents in the collection "conversations".
  /// It only applies this operation on normal conversations by filtering
  /// out any spammed or archived conversations.
  Future<void> markAllConversationsRead() {
    return _service.batchActon(
      path: FirestorePath.conversations(uid),
      changes: {'isRead': true},
      queryBuilder: (query) => query
          .where('isSpam', isEqualTo: false)
          .where('isArchived', isEqualTo: false),
    );
  }

  /// Deletes the provided conversation document.
  Future<void> deleteConversation(Conversation conversation) {
    return _service.deleteData(
      path: FirestorePath.conversation(uid, conversation.sender.number),
    );
  }

  /// Updates an entire group document or adds it if it doesn't exist.
  Future<void> addOrUpdateGroup(Conversation conversation, {bool merge}) {
    return _service.setData(
      path: FirestorePath.group(uid, conversation.groupID),
      data: conversation.toMap(),
      merge: merge
    );
  }

  /// Deletes the provided group document.
  Future<void> deleteGroup(Conversation conversation) {
    return _service.deleteData(
      path: FirestorePath.group(uid, conversation.groupID),
    );
  }

  /// Updates an entire contact document or adds it if it doesn't exist.
  Future<void> addOrUpdateContact(Contact contact, {bool merge = false}) {
    return _service.setData(
        path: FirestorePath.contact(uid, contact.number),
        data: contact.toMap(),
        merge: merge
    );
  }

  /// Returns a stream of a single conversation fetched from the conversation
  /// document at the provided number.
  Stream<Conversation> conversationStream({@required String number}) {
    return _service.documentStream(
      path: FirestorePath.conversation(uid, number),
      builder: (data, documentId) => Conversation.fromMap(data),
    );
  }

  /// Returns a stream of a single group fetched from the group
  /// document at the provided groupID.
  Stream<Conversation> groupStream({@required String groupID}) {
    return _service.documentStream(
      path: FirestorePath.group(uid, groupID),
      builder: (data, documentId) => Conversation.fromMap(data),
    );
  }

  /// Returns a stream of a single contact fetched from the contact
  /// document at the provided number.
  Stream<Contact> contactStream({@required String number}) {
    return _service.documentStream(
      path: FirestorePath.contact(uid, number),
      builder: (data, documentId) => Contact.fromMap(data),
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

  /// Returns a stream of a list of all normal conversations
  /// that are neither spammed nor archived, sorted in ascending
  /// order.
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

  /// Returns a stream of a list of all spammed conversations,
  /// sorted in ascending order.
  Stream<List<Conversation>> spammedStream() {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.conversations(uid),
      queryBuilder: (query) => query.where('isSpam', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.sender.name.compareTo(lhs.sender.name),
    );
  }

  /// Returns a stream of a list of all archived conversations,
  /// sorted in ascending order.
  Stream<List<Conversation>> archivedStream({Conversation conversation}) {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.conversations(uid),
      queryBuilder: (query) => query
          .where('isArchived', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.sender.name.compareTo(lhs.sender.name),
    );
  }


  /// Returns a stream of a list of all normal groups
  /// that are neither spammed nor archived, sorted in ascending
  /// order.
  Stream<List<Conversation>> normalGroupsStream({Conversation conversation}) {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.groups(uid),
      queryBuilder: (query) => query
          .where('isGroup', isEqualTo: true)
          .where('isSpam', isEqualTo: false)
          .where('isArchived', isEqualTo: false),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.groupName.compareTo(lhs.groupName),
    );
  }

  /// Returns a stream of a list of all spammed groups,
  /// sorted in ascending order.
  Stream<List<Conversation>> spammedGroupsStream() {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.groups(uid),
      queryBuilder: (query) => query.where('isSpam', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.groupName.compareTo(lhs.groupName),
    );
  }

  /// Returns a stream of a list of all archived groups,
  /// sorted in ascending order.
  Stream<List<Conversation>> archivedGroupsStream({Conversation conversation}) {
    return _service.collectionStream<Conversation>(
      path: FirestorePath.groups(uid),
      queryBuilder: (query) => query
          .where('isArchived', isEqualTo: true),
      builder: (data, _) => Conversation.fromMap(data),
      sort: (lhs, rhs) => rhs.groupName.compareTo(lhs.groupName),
    );
  }

  /// Returns a stream of a list of all normal contacts,
  /// sorted in ascending order.
  Stream<List<Contact>> contactsStream() {
    return _service.collectionStream<Contact>(
      path: FirestorePath.contacts(uid),
      builder: (data, _) => Contact.fromMap(data),
      sort: (lhs, rhs) => lhs.name.compareTo(rhs.name),
    );
  }
}
