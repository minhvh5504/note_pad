import 'package:flutter/material.dart';
import 'package:note_pad/feature/data/services/firestore_service.dart';

class NoteBox extends StatefulWidget {
  final String? docID;
  final String action;
  final String? currentDate;
  final String? currentDescription;

  const NoteBox({
    super.key,
    this.docID,
    required this.action,
    this.currentDate,
    this.currentDescription,
  });

  @override
  State<NoteBox> createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  final FirestoreService firestore = FirestoreService();
  late final TextEditingController dateController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: widget.currentDate ?? "");
    descriptionController = TextEditingController(
      text: widget.currentDescription ?? "",
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final date = dateController.text.trim();
    final desc = descriptionController.text.trim();
    if (date.isEmpty && desc.isEmpty) {
      Navigator.pop(context);
      return;
    }

    if (widget.docID == null) {
      firestore.addNote(date, desc);
    } else {
      firestore.updateNotesById(widget.docID!, date, desc);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.action} note"),
      titleTextStyle: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.cyanAccent.shade700,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: "Date",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(widget.action),
        ),
      ],
    );
  }
}
