import 'package:flutter/cupertino.dart';
import '../models/note.dart';
import 'note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    required this.notes,
    super.key});

  final List<Note> notes;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),

      //id of the index ie=the number
      itemBuilder: (context, int index) {
        return  NoteCard(

          //brings the notes with its index number
            note: notes[index],
            isInGrid: true);
      },
    );
  }
}
