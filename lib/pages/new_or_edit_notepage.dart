import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_firebase/change_notifier/new_note_controller.dart';
import 'package:notes_firebase/core/constants.dart';
import 'package:notes_firebase/core/dialogs.dart';
import 'package:notes_firebase/widgets/new_note_dialog.dart';
import 'package:notes_firebase/widgets/note_button.dart';
import 'package:notes_firebase/widgets/note_icon_button.dart';
import 'package:notes_firebase/widgets/note_icon_button_outlined.dart';
import 'package:notes_firebase/widgets/note_metadata.dart';
import 'package:provider/provider.dart';

import '../widgets/confirmation_dialog.dart';
import '../widgets/note_dialog_card.dart';
import '../widgets/note_tag.dart';

class NewOrEditNotepage extends StatefulWidget {
  const NewOrEditNotepage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewOrEditNotepage> createState() => _NewOrEditNotepageState();
}

class _NewOrEditNotepageState extends State<NewOrEditNotepage> {
  late final NewNoteController newNoteController;
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  //to focus on editing when in edit mode
  late final FocusNode focusNode;

  // //to enable or disable keyboard in read mode
  // late bool readOnly;

  @override
  void initState() {
    super.initState();
    //fetches newNoteController and assign it to newNoteController
    newNoteController = context.read<NewNoteController>();
    titleController = TextEditingController(text: newNoteController.title);
    contentController = TextEditingController(text: newNoteController.content);

    focusNode = FocusNode();

    //to tackle the readonly issue and so pen emoji

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //this is called after forming the widget after 1 frame
      if (widget.isNewNote) {
        focusNode.requestFocus();
        //if new note, read only is false
        newNoteController.readOnly = false;
      } else {
        //in edit mode its true
        newNoteController.readOnly = true;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //for accidental backs
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        //if no content is written no dialog box is shown when back button called
        if (!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showConfirmationDialog(context: context, title: '');
        //user clicks outside the box, return nothing
        if (shouldSave == null) return;
        if (!context.mounted) return;
        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },

      child: Scaffold(
        appBar: AppBar(
          //for icon in the front
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: NoteIconButtonOutlined(
              icon: FontAwesomeIcons.chevronLeft,
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ),
          title: Flexible(
            child: Text(
              widget.isNewNote ? 'New Note' : 'Edit Note',
              style: const TextStyle(color: Colors.amber),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: [
            //selector listen to specific changes at specific places and builds only that, not everything
            Selector<NewNoteController, bool>(
              //selects readonly
              selector:
                  (context, newNoteController) => newNoteController.readOnly,
              //and builds the icon button based on readonly and context
              builder:
                  (context, readOnly, child) => NoteIconButtonOutlined(
                    icon:
                        readOnly
                            ? FontAwesomeIcons.pencil
                            : FontAwesomeIcons.bookOpen,
                    onPressed: () {
                      newNoteController.readOnly = !readOnly;

                      if (newNoteController.readOnly) {
                        //in readonly remove focus ie keyboard
                        //focusscope will unfocus the keyboard
                        FocusScope.of(context).unfocus();
                      } else {
                        //if not readonly, ie., in edit mode.... request focus
                        focusNode.requestFocus();
                      }
                    },
                  ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder:
                  (_, canSaveNote, __) => NoteIconButtonOutlined(
                    icon: FontAwesomeIcons.check,
                    onPressed:
                        canSaveNote
                            ? () {
                              newNoteController.saveNote(context);
                              Navigator.pop(context);
                            }
                            : null,
                  ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                //return the text field and listen to readonly changes
                builder:
                    (context, readOnly, child) => TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: gray300),
                        border: InputBorder.none,
                      ),

                      //keyboard can be allowed only when not in read only mode
                      canRequestFocus: !readOnly,
                      //on change of words
                      onChanged: (newValue) {
                        newNoteController.title = newValue;
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),

              NoteMetadata(note: newNoteController.note,),
              //for line
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: gray500, thickness: 2),
              ),

              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  //return the text field and listen to readonly changes
                  builder:
                      (_, readOnly, __) => TextField(
                        controller: contentController,
                        decoration: InputDecoration(
                          hintText: 'Note here...',
                          hintStyle: TextStyle(color: gray300),
                          border: InputBorder.none,
                        ),

                        //gets the logic frm above
                        readOnly: readOnly,
                        //listen to change of words
                        onChanged: (newValue) {
                          newNoteController.content = newValue;
                        },

                        //controls the focus of the keyboard
                        focusNode: focusNode,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
