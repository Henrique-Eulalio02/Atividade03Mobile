class Note {
  String title = "";
  String description = "";
  String noteId = "";

  Note() {
    title = "";
    description = "";
    noteId = "";
  }

  Note.withData({
    this.title = "",
    this.description = "",
    this.noteId = ""
  });

  // estamos convertendo um MAP para um objeto note
  Note.fromMap(map) {
    title = map["title"];
    description = map["description"];
  }

  // processo contrário do fromMap
  toMap() {
    var map = <String, dynamic>{};

    map["title"] = title;
    map["description"] = description;

    return map;
  }
}