import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_firebase/change_notifier/new_note_controller.dart';
import 'package:notes_firebase/change_notifier/notes_provider.dart';
import 'package:notes_firebase/core/constants.dart';
import 'package:notes_firebase/pages/new_or_edit_notepage.dart';
import 'package:notes_firebase/widgets/note_icon_button.dart';
import 'package:notes_firebase/widgets/search_field.dart';
import 'package:notes_firebase/widgets/view_options.dart';
import 'package:provider/provider.dart';

import '../core/dialogs.dart';
import '../models/note.dart';
import '../services/auth_services.dart';
import '../widgets/no_notes.dart';
import '../widgets/note_icon_button_outlined.dart';
import '../widgets/notes_fab.dart';
import '../widgets/notes_grid.dart';

import '../widgets/notes_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes📒', style: TextStyle(color: Colors.amber)),

        //action button for exiting on app bar
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteIconButtonOutlined(
              icon: FontAwesomeIcons.rightFromBracket,
              onPressed: () async {
                final bool shouldLogout = await showConfirmationDialog(
                  context: context,
                  title: 'Do you want to sign out of the app?',
                ) ??
                    false;
                if (shouldLogout) AuthService.logout();
              },
            ),
          ),
        ],
      ),

      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChangeNotifierProvider(
                    create: (context) => NewNoteController(),
                    child: NewOrEditNotepage(
                      //fab button clicked only for new note
                      isNewNote: true,
                    ),
                  ),
            ),
          );
        },
      ),

      //generic type widget comes with provider
      //needed to add info
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;

          //for if notes is empty or no search term in search bar then show column text otherwise show notes
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? const NoNotes()
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //this is a search bar
                    SearchField(),
                    if (notes.isNotEmpty) ...[
                      //this is for date wise selection and changing layout in the row section
                      ViewOptions(),
                      //expanded fills the rest of the screen with just the gridview
                      Expanded(
                        //either show grid view or list view
                        child:
                            notesProvider.isGrid
                                ? NotesGrid(notes: notes)
                                : NotesList(notes: notes),
                      ),
                    ] else
                      Expanded(
                        child: Center(
                          child: Text(
                            "No Notes Found",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
