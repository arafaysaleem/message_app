import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  /// Singleton instance of a firestoreService class.
  static final instance = FirestoreService._();

  /// Sets the data for the document/collection existing
  /// at the provided path.
  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path');
    await reference.set(data, SetOptions(merge: merge));
  }

  /// Checks if the document/collection exists
  /// at the provided path.
  Future<bool> checkDocument({@required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshot = await reference.get();
    print('$path exists: ${snapshot.exists}');
    return snapshot.exists;
  }

  /// Deletes the document/collection existing at the
  /// provided path.
  Future<void> deleteData({@required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  /// Updates data in a single document existing at the provided
  /// path by performing the changes according to the supplied
  /// changes map.
  Future<void> documentAction({
    @required String path,
    @required Map<String, dynamic> changes,
  }) async {
    print('$path');

    final docRef = FirebaseFirestore.instance.doc(path);

    docRef.update(changes);
  }

  /// Updates data in a list of documents of a single collection
  /// existing at the provided path. The documents are filted by
  /// the queryBuilder and updated by performing the changes according
  /// to the supplied changes map.
  Future<void> batchActon({
    @required String path,
    @required Map<String, dynamic> changes,
    Query Function(Query query) queryBuilder,
  }) async {
    final batchUpdate = FirebaseFirestore.instance.batch();
    print('$path');
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final querySnapshot = await query.get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchUpdate.update(ds.reference, changes);
    }
    await batchUpdate.commit();
  }

  /// Returns a stream of collection mapped to a list of type T,
  /// existing at the provided path and filtered using the queryBuilder.
  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query) queryBuilder,
    int Function(T lhs, T rhs) sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  /// Returns a stream of document mapped to a list of type T,
  /// existing at the provided path.
  Stream<T> documentStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }
}
