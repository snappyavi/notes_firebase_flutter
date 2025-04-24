class Note {

  //constructor Time

  Note({
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.dateModified,
    required this.tags,
  });


  // nullable: ?
  final String? title;
  final String? content;

  final int dateCreated;
  final int dateModified;
  final List<String>? tags;
}