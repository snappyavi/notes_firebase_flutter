//stful widget to show notes as list
import 'package:flutter/cupertino.dart';

import '../models/note.dart';
import 'note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    required this.notes,
    super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    //for space in b/w lists
    return ListView.separated(
      //to not clip the right shadow
      clipBehavior: Clip.none,
      //returns total no of notes
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return  NoteCard(
          //notes for each index
            note:notes[index],
            isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}
