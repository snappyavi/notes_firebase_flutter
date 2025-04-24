import 'package:flutter/cupertino.dart';
import '../models/note.dart';


//searches for the tag in sentences
extension ListDeepContains on List<String> {
  bool deepContains(String term) =>
     contains(term) || any((element) => element.contains(term));
}

class NotesProvider extends ChangeNotifier {
  //listr of notes = _notes, the list is final ie can be changed, comes in an array
  //_notes=made private
  final List<Note> _notes = [];

  //notes is the public function
  List<Note> get notes =>
      [..._searchTerm.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Note note) {
    final term = _searchTerm.toLowerCase().trim();
    //if null returns empty string
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';

    //maps each element to lowercase
    final tags = note.tags?.map((e) => e.toLowerCase()).toList() ?? [];
    return title.contains(term) ||
        content.contains(term) ||
        //for tags to return while in search
        tags.deepContains(term);
  }

  int _compare(Note note1, note2) {
    return _orderby == OrderOption.dateModified
        ? _isDescending
            ? note2.dateModified.compareTo(note1.dateModified)
            : note1.dateModified.compareTo(note2.dateModified) //ascending arrow
        : _isDescending
        ? note2.dateCreated.compareTo(note1.dateCreated)
        : note1.dateCreated.compareTo(note2.dateCreated); //ascending arrow
  }

  //[] = does not allows to modify the private ones via the public ones

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    //the index is as per the date created to find
    final index = _notes.indexWhere(
      (element) => element.dateCreated == note.dateCreated,
    );
    //notes index will be the new note
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  //shows the first value from the droopdown options ie date modified
  OrderOption _orderby = OrderOption.dateModified;

  set orderBy(OrderOption value) {
    _orderby = value;
    notifyListeners();
  }

  OrderOption get orderBy => _orderby;

  //for icons actions
  //desceding view
  bool _isDescending = true;

  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  //grid view
  bool _isGrid = true;

  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTerm = '';

  set searchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
  }

  String get searchTerm => _searchTerm;
}

enum OrderOption {
  dateModified,
  dateCreated;

  //override the name property of enum ie dates
  String get name {
    //switches the name
    return switch (this) {
      OrderOption.dateModified => 'Modified Date',
      OrderOption.dateCreated => 'Created Date',
    };
  }
}
