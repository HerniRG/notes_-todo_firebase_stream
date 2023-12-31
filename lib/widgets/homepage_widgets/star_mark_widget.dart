import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firestore_services.dart';

class StarMarkWidget extends StatelessWidget {
  final bool hasStar;

  const StarMarkWidget({
    required this.hasStar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      width: 30.0,
      child: Icon(
        hasStar ? Icons.star : Icons.star_border,
        color: hasStar ? Colors.red : Colors.grey,
        size: 20.0,
      ),
    );
  }
}

void starMark(String docId, Map<String, dynamic>? noteData, context,
    FirestoreService firestoreService, TextEditingController textController) {
  textController.text = noteData?['note'] ?? '';
  bool hasStar = noteData?['hasStar'] ?? false;

  firestoreService.updateNote(docId, textController.text,
      !hasStar); // Invierte el estado de la notificación
}
