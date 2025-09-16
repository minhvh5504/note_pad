import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:note_pad/feature/data/services/firestore_service.dart';
import 'package:note_pad/feature/presentation/screens/no_notepad_screen.dart';
import 'package:note_pad/feature/presentation/widgets/notbox.dart';

class NotepadScreen extends StatelessWidget {
  NotepadScreen({super.key});

  // Firestore
  final FirestoreService firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.cyanAccent.shade400,
        title: const Text("Notes"),
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.amber,
        hoverColor: Colors.amber,
        backgroundColor: Colors.cyanAccent.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          // Add → truyền 2 trường rỗng
          openNoteBox(context, null, "Add", "", "");
        },
        child: const Icon(LucideIcons.plus, size: 30, color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const NoNotepadScreen();
          }

          final noteList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = noteList[index];
              String docID = document.id;

              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String date = data['date'] ?? '';
              String description = data['description'] ?? '';

              return ListTile(
                title: Text(date),
                subtitle: Text(description),
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // update button
                    IconButton(
                      onPressed: () {
                        openNoteBox(
                          context,
                          docID,
                          "Update",
                          date,
                          description,
                        );
                      },
                      icon: const Icon(LucideIcons.edit, color: Colors.black54),
                    ),
                    // delete button
                    IconButton(
                      onPressed: () {
                        firestore.deleteNotesById(docID);
                      },
                      icon: const Icon(
                        LucideIcons.trash,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void openNoteBox(
    BuildContext context,
    String? docID,
    String action, [
    String? currentDate,
    String? currentDescription,
  ]) {
    showDialog(
      context: context,
      builder: (context) => NoteBox(
        docID: docID,
        action: action,
        currentDate: currentDate,
        currentDescription: currentDescription,
      ),
    );
  }
}
