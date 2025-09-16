import 'package:flutter/material.dart';

class NoNotepadScreen extends StatelessWidget {
  const NoNotepadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_note.png', fit: BoxFit.contain),
          const SizedBox(height: 16),
          const Text(
            'No notes avaliable!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
