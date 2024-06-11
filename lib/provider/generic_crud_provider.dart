import 'dart:async';
import 'package:dio/dio.dart';

import 'package:atividade04/model/note.dart';

class GenericCrudProvider {
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();
  GenericCrudProvider._createInstance();

  Dio _dio = Dio();

  String prefixUrl =
      "https://228e0f9b-cc0e-46b8-b982-67ceddb13592-00-zz9hf5unluqi.picard.replit.dev/notes/";

  /*Map<String, Note> database = {
    "a": Note.withData(title: "Primeiro titulo", description: "Primeira descrição", noteId: "a"),
    "b": Note.withData(title: "Segundo titulo", description: "Segunda descrição", noteId: "b"),
  };*/

  int numInsertions = 0;

  Future<List<Note>> getNoteList() async {
     Response response = await _dio.get(prefixUrl);

    List<Note> noteCollection = [];

    response.data.forEach((key, value) {
      Note note = Note.fromMap(value);
      note.noteId = key;
      //noteCollection.insertNoteOfId(value["id"].toString(), note);

      noteCollection.add(note);
    });

    return noteCollection;
  }

  Future<Note> getNote(String noteId) async {
   Response response = await _dio.get(prefixUrl + noteId + "/");
    return Note.fromMap(response.data);
  }

  Future<String> insertNote(Note note) async {
    String key = numInsertions.toString();
     await _dio.post(
      prefixUrl,
      data: note.toMap(),
    );
    return key;
  }

  Future<String> updateNote(String noteId, Note note) async {
    await _dio.put(
      prefixUrl + noteId + "/",
      data: note.toMap(),
    );
    _controller.sink.add(noteId);
    return noteId;
  }

  Future<String> deleteNote(String noteId) async {
    await _dio.delete(prefixUrl + noteId + "/");
    _controller.sink.add(noteId);
    return noteId;
  }

  final StreamController _controller = StreamController();

  Stream get stream {
    return _controller.stream;
  }
}