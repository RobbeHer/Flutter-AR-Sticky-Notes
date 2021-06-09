import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/note.dart';

class NoteApi {
  static String url = "https://great-emu-51.loca.lt/notes/";

  /// gets all notes
  static Future<List<Note>> getNotes() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((note) => new Note.fromJson(note)).toList();
    } else {
      throw Exception("De notities konden niet worden geladen.");
    }
  }

  /// gets a single specific note
  static Future<Note> getNote(String id) async {
    final response = await http.get(url + id.toString());
    if (response.statusCode == 200)
      return Note.fromJson(jsonDecode(response.body));
    else
      throw Exception("De notitie kon niet geladen worden.");
  }

  /// creates an extra note
  static Future<Note> createNote(Note note) async {
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        "Content-type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(note),
    );
    if (response.statusCode == 201)
      return Note.fromJson(jsonDecode(response.body));
    else
      throw Exception("De notities kon niet gecreërd worden.");
  }

  /// updates a specific note
  static Future<Note> updateNote(String id, Note note) async {
    final http.Response response = await http.put(
      url + id.toString(),
      headers: <String, String>{
        "Content-type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(note),
    );
    if (response.statusCode == 200)
      return Note.fromJson(jsonDecode(response.body));
    else
      throw Exception("De notitie kon niet geüpdated worden.");
  }

  /// deletes a note
  static Future deleteNote(String id) async {
    final http.Response response = await http.delete(url + id.toString());
    if (response.statusCode == 200)
      return;
    else
      throw Exception("De notitie kon niet verwijderd worden.");
  }
}
