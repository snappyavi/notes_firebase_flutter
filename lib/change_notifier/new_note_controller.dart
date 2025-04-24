import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_firebase/change_notifier/notes_provider.dart';
import 'package:notes_firebase/models/note.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
  //for note present or null
  Note? _note;

  set note(Note? value) {
    _note = value;
    //null check for note and title if empty return empty or result
    _title = _note!.title ?? '';
    _content = _note!.content ?? '';
    _tags.addAll(_note!.tags ?? []);
    notifyListeners();
  }

  Note? get note => _note;

  bool _readOnly = false;

  set readOnly(bool value) {
    //sets readonly to the bool value
    _readOnly = value;
    notifyListeners(); //notifies listener
  }

  bool get readOnly => _readOnly; //sets and gets

  String _title = '';

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();

  //for the content in notes
  String _content = '';

  set content(String value) {
    _content = value;
    notifyListeners();
  }

  String get content => _content;

  //for the tags
  final List<String> _tags = [];

  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => [..._tags];

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  void updateTag(String tag,  int index) {
    _tags[index]=tag;
    notifyListeners();
  }

  bool get isNewNote => _note == null;

  bool get canSaveNote {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent =
        content.trim().isNotEmpty ? content.trim() : null;

    // for every new note,save only when title or content is there

    bool canSave = newTitle != null || newContent != null;

    if (!isNewNote) {
      //if not a new note then the new title and content should not be same as previous
      canSave &=
          newTitle != note!.title ||
              newContent != note!.content ||
              !listEquals(tags, note!.tags);
    }
    return canSave;
  }

  void saveNote(BuildContext context) {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent =
        content.trim().isNotEmpty ? content.trim() : null;
    final int now = DateTime.now().microsecondsSinceEpoch;
    final Note note = Note(
      title: newTitle,
      content: newContent,
      dateCreated: isNewNote? now: _note!.dateCreated,
      dateModified: now,
      tags: tags,
    );
final notesProvider= context.read<NotesProvider>();
    isNewNote? notesProvider.addNote(note):notesProvider.updateNote(note);
  }
}
