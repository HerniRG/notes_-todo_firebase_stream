import 'package:flutter/material.dart';
import 'package:todo_firebase/widgets/homepage_widgets/star_mark_widget.dart';

class NoteListItem extends StatelessWidget {
  final String docId;
  final String note;
  final bool hasStar;

  final Function onEdit;
  final Function onDelete;
  final Function starMark;

  const NoteListItem({
    required this.docId,
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.starMark,
    super.key,
    required this.hasStar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(note),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => onEdit(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => starMark(),
              child: StarMarkWidget(
                hasStar: hasStar,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
