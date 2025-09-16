import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreService {
  // get collection of notes
  final CollectionReference<Map<String, dynamic>> notes = FirebaseFirestore
      .instance
      .collection("notes");

  // CREATE: add a new note
  Future<void> addNote(String date, String description) {
    return notes.add({
      'date': date,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get notes from database
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  // UPDATE: update notes given a doc id
  Future<void> updateNotesById(String docID, String date, String description) {
    return notes.doc(docID).update({
      'date': date,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes given a doc id
  Future<void> deleteNotesById(String docID) {
    return notes.doc(docID).delete();
  }
}
