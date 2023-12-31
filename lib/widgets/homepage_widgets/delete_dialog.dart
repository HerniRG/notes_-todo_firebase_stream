// delete_dialog.dart
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final Function onDelete;

  const DeleteDialog({required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Note'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

void openDeleteDialog(String docId, context, firestoreService) {
  showDialog(
    context: context,
    builder: (context) => DeleteDialog(
      onDelete: () {
        firestoreService.deleteNote(docId);
      },
    ),
  );
}
