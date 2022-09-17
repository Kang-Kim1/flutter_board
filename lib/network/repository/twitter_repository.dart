
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BoardRepository {
  Stream<QuerySnapshot> getAllTwits();
  Future<void> postTweet({required Map<String, dynamic> entity});
  Future<void> editTweet({required String docId, required String contents});
  Future<void> deleteTweet({required String docId});
}

class FireStoreTwitterRepository implements BoardRepository {
  final collectionPath = 'flutter_board';

  @override
  Stream<QuerySnapshot> getAllTwits() {
    return FirebaseFirestore.instance.collection(collectionPath)
        .orderBy('timeUploaded', descending: true).snapshots();
  }

  @override
  Future<void> postTweet({required Map<String, dynamic> entity}) {
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    return collection
        .add(entity);
  }

  @override
  Future<void> editTweet({required String docId, required String contents}) async {
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    return collection
        .doc(docId)
        .update({'contents' : contents}); // <-- Nested value
  }

  @override
  Future<void> deleteTweet({required String docId}) {
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    return collection
        .doc(docId)
        .delete(); // <-- Nested value
  }
}