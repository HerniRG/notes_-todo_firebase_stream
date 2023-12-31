import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/pages/auth/auth_page.dart';
import 'package:todo_firebase/services/auth_services.dart';
import 'package:todo_firebase/services/firestore_services.dart';
import 'package:todo_firebase/widgets/homepage_widgets/delete_dialog.dart';
import 'package:todo_firebase/widgets/homepage_widgets/note_dialog.dart';
import 'package:todo_firebase/widgets/homepage_widgets/star_mark_widget.dart';
import '../widgets/homepage_widgets/note_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void signUserOut() {
    AuthService().signUserOut(
      showMessage: (message) => showSnackBar(message),
      context: context,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: buildAppBar(user),
      floatingActionButton: buildFloatingActionButton(),
      body: buildNotesList(),
    );
  }

  AppBar buildAppBar(User? user) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: signUserOut,
          icon: const Icon(Icons.logout),
        ),
      ],
      backgroundColor: Colors.yellow,
      title: buildAppBarTitle(user),
    );
  }

  Column buildAppBarTitle(User? user) {
    return Column(
      children: [
        const Text('Notes Cloud'),
        Text('${user?.email}'),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () =>
          openNoteDialog(null, null, context, firestoreService, textController),
      child: const Icon(Icons.add),
    );
  }

  Widget buildNotesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.readNotes(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> notesList = snapshot.data!.docs;
          return buildNotesListContent(notesList);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading notes'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildNotesListContent(List<DocumentSnapshot> notesList) {
    return notesList.isEmpty
        ? const Center(child: Text('No notes'))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = notesList[index];
              String docId = document.id;
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String note = data['note'];
              bool hasStar = data['hasStar'] ?? false;

              return NoteListItem(
                docId: docId,
                note: note,
                hasStar: hasStar,
                onEdit: () => openNoteDialog(
                    docId, data, context, firestoreService, textController),
                onDelete: () =>
                    openDeleteDialog(docId, context, firestoreService),
                starMark: () => starMark(
                    docId, data, context, firestoreService, textController),
              );
            },
          );
  }
}
