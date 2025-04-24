import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_firebase/core/dialogs.dart';
import 'package:notes_firebase/core/utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/new_note_controller.dart';
import '../core/constants.dart';
import '../models/note.dart';
import 'new_note_dialog.dart';
import 'note_dialog_card.dart';
import 'note_icon_button.dart';
import 'note_tag.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({required this.note, super.key});

  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newNoteController = context.read();
  }

  // get newNoteController => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
          Row(
            children: [
              Expanded(
                //row is divided into total 7 parts
                //3 space is taken by this
                flex: 3,
                child: const Text(
                  'Last Modified',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                //4 space is taken by this
                flex: 4,
                child: Text(
                  toLongDate(widget.note!.dateModified),
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Created At',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  toLongDate(widget.note!.dateCreated),
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                ),
              ),
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    'Add Tags',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray500,
                    ),
                  ),
                  SizedBox(width: 8),
                  NoteIconButton(
                    icon: FontAwesomeIcons.circlePlus,
                    onPressed: () async {
                      final String? tag = await showNewTagDialog(
                        context: context,
                      );

                      if (tag != null) {
                        newNoteController.addTag(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Selector<NewNoteController, List<String>>(
                selector: (_, newNoteController) => newNoteController.tags,
                builder:
                    (_, tags, __) =>
                        tags.isEmpty
                            ? Text(
                              'No Tags',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: gray900,
                              ),
                            )
                            : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  tags.length,
                                  (index) => NoteTag(
                                    label: tags[index],
                                    onClosed: () {
                                      newNoteController.removeTag(index);
                                    },
                                    onTap: () async {
                                      final String? tag =
                                          await showNewTagDialog(
                                            context: context,
                                            tag: tags[index],
                                          );

                                      //update tag only if different from previous tag

                                      if (tag != null && tag != tags[index]) {
                                        newNoteController.updateTag(tag, index);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
