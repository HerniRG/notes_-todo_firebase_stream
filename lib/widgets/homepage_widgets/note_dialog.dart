// note_dialog.dart
import 'package:flutter/material.dart';
import 'package:todo_firebase/services/firestore_services.dart';

class NoteDialog extends StatelessWidget {
  final TextEditingController textController;
  final Function(String?) onSubmit;
  final bool isEdit;

  const NoteDialog({
    required this.textController,
    required this.onSubmit,
    required this.isEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: isEdit ? const Text('Edit Note') : const Text('Add Note'),
      content: TextField(
        decoration: const InputDecoration(hintText: 'Enter your note here'),
        controller: textController,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            textController.text = textController.text.trim();
            if (textController.text.isEmpty) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a note'),
                ),
              );
              return;
            }

            onSubmit(textController.text);
            textController.clear();
            Navigator.pop(context);
          },
          child: isEdit ? const Text('Edit') : const Text('Add'),
        ),
      ],
    );
  }
}

void openNoteDialog(String? docId, Map<String, dynamic>? noteData, context,
    FirestoreService firestoreService, TextEditingController textController) {
  textController.text = noteData?['note'] ?? '';
  bool hasStar = noteData?['hasStar'] ?? false;

  showDialog(
    context: context,
    builder: (context) => NoteDialog(
      isEdit: docId != null,
      textController: textController,
      onSubmit: (value) {
        if (docId == null) {
          // Crear nueva nota
          firestoreService.createNote(textController.text, hasStar, null);
        } else {
          // Actualizar nota existente
          firestoreService.updateNote(
            docId,
            textController.text,
            hasStar,
          );
        }
      },
    ),
  );
}
