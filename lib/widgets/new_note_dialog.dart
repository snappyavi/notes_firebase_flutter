import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_firebase/widgets/note_dialog_card.dart';
import 'package:notes_firebase/widgets/note_button.dart';
import '../core/constants.dart';
import 'note_button.dart';
import 'note_form_field.dart';

class NewNoteDialog extends StatefulWidget {
  const NewNoteDialog({this.tag, super.key});

 // final Widget child;
  final String? tag;

  @override
  State<NewNoteDialog> createState() => _NewNoteDialogState();
}

class _NewNoteDialogState extends State<NewNoteDialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();

    tagController = TextEditingController(text: widget.tag);

    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoteDialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 24),
          NoteFormField(
            key: tagKey,
            controller: tagController,
            labelText: 'Add(Upto 16 character)',

            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'No tags added';
              } else if (value.trim().length > 16) {
                return 'Tags should not be more than 16 characters';
              }
              return null;
            },
            onChanged: (newValue) {
              tagKey.currentState?.validate();
            },
          ),

          SizedBox(height: 24),
          NoteButton(
            child: Text('Add'),

            onPressed: () {
              if (tagKey.currentState?.validate() ?? false) {
                Navigator.pop(context, tagController.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
