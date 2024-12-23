import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addMeetingHistory(String roomName) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      print(userId);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('meetingHistory')
          .add({
        'meetingName': roomName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding meeting history: $e");
    }
  }

  Stream<QuerySnapshot> get meetingsHistory {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('meetingHistory')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> clearMeetingHistory() async {
    try {
      var collection = _firestore.collection('meetings');
      var querySnapshot = await collection.get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear meeting history: $e');
    }
  }
}
