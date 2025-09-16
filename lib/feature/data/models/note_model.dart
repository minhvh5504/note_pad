import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String date;
  final String description;
  final Timestamp timestamp;

  Note({
    required this.id,
    required this.date,
    required this.description,
    required this.timestamp,
  });

  factory Note.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      date: data['date'] ?? '',
      description: data['description'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'date': date, 'description': description, 'timestamp': timestamp};
  }
}
