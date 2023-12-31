import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createNote(
      String note, bool hasStar, DateTime? notificationDateTime) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (userId.isNotEmpty) {
        Map<String, dynamic> noteData = {
          'note': note,
          'hasStar': false,
          'timestamp': DateTime.now(),
        };

        // Agregar la notificación solo si se proporciona la fecha y hora
        if (notificationDateTime != null) {
          noteData['notificationDateTime'] = notificationDateTime;
          noteData['hasStar'] = true;
        }

        await users.doc(userId).collection('user_notes').add(noteData);
      } else {
        if (kDebugMode) {
          print('User not authenticated. Unable to create note.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating note: $e');
      }
    }
  }

  Stream<QuerySnapshot> readNotes() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      final notesStream =
          users.doc(userId).collection('user_notes').snapshots();
      return notesStream;
    } else {
      if (kDebugMode) {
        print('User not authenticated. Unable to read notes.');
      }
      return const Stream<QuerySnapshot>.empty();
    }
  }

  Future<void> updateNote(String noteId, String note, bool hasStar) {
    return users
        .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
        .collection('user_notes')
        .doc(noteId)
        .update(
            {'note': note, 'hasStar': hasStar, 'timestamp': DateTime.now()});
  }

  Future<void> deleteNote(String noteId) {
    return users
        .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
        .collection('user_notes')
        .doc(noteId)
        .delete();
  }
}
