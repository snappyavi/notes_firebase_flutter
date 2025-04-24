import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_firebase/change_notifier/new_note_controller.dart';
import 'package:notes_firebase/change_notifier/notes_provider.dart';
import 'package:notes_firebase/core/dialogs.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';
import '../core/utils.dart';
import '../models/note.dart';
import '../pages/new_or_edit_notepage.dart';
import 'note_tag.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, required this.isInGrid, super.key});

  //Note invoked
  final Note note;

  //we use expanded in grid mode but can't be used in list, so for that
  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //shows the note in edit mode card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                ChangeNotifierProvider(
                  create: (_) =>
                  NewNoteController()
                    ..note = note,
                  child: NewOrEditNotepage(
                    //fab button clicked only for new note
                    isNewNote: false,
                  ),
                ),
          ),
        );
      },
      child: Container(
        //decorating the grid Boxes for notes
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.amberAccent.withOpacity(0.5),
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //for the heading
            if (note.title != null) ...[
              Text(
                note.title ?? "No Title", //!=null check error
                maxLines: 1,
                //in case the title is long, it adds 3 dots in the end
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: gray900,
                ),
              ),
              SizedBox(height: 4),
            ],
            if (note.tags != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  //for the chip info
                  //list.generates and returns 3 containers
                  children: List.generate(
                    note.tags!.length,
                        (index) =>
                        NoteTag(
                          label: note.tags![index],
                          onClosed: () {},
                          onTap: () {},
                        ),
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
            if (note.content != null)

            ///...[
              isInGrid
                  ?
              //takes rest of the space
              Expanded(
                child: Text(
                  note.content ?? "No Content",
                  //restricts the content to 3 lines and adds dots
                  style: TextStyle(color: gray700),
                ),
              )
                  : Text(
                note.content!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: gray700),
              ),

            if (isInGrid) Spacer(),
            Row(
              children: [
              Selector<NotesProvider, OrderOption > (
            selector: (_, notesProvider) => notesProvider.orderBy,
            builder:
                (_, orderBy, __) =>
                Text(
                  toShortDate(
                    orderBy == OrderOption.dateModified
                        ? note.dateModified
                        : note.dateCreated,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gray500,
                  ),
                ),
            ),
              //to place at the end
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  final shouldDelete =
                      await showConfirmationDialog(context: context, title: 'Do you want to delete it?') ??
                          false;

                  if (shouldDelete && context.mounted) {
                    context.read<NotesProvider>().deleteNote(note);
                  }
                },
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  color: gray500,
                  size: 16,
                ),
              ),

          ],
        ),
        ],
      ),
    ),);
  }
}
