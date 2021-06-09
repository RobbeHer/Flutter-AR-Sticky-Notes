import 'package:flutter/material.dart';

//models
import '../models/note.dart';
//apis
import '../apis/note_api.dart';

class NoteEditPage extends StatefulWidget {
  final String id;
  NoteEditPage(this.id);

  @override
  _NoteEditPageState createState() => _NoteEditPageState(id);
}

final List<String> choices = const <String>[
  'Sla notitie op & Ga naar overzicht',
  'Verwijder notitie',
  'Ga terug naar overzicht'
];

class _NoteEditPageState extends State<NoteEditPage> {
  String id;
  _NoteEditPageState(this.id);

  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getNote(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notitie bewerken",
          style: TextStyle(
            fontFamily: "AmaticSC",
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuSelected,
            itemBuilder: (BuildContext context) {
              return choices.asMap().entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key.toString(),
                  child: Text(
                    entry.value,
                    style: TextStyle(fontFamily: "JosefinSans"),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _noteDetails(),
      ),
    );
  }

  _noteDetails() {
    if (note == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      TextStyle textStyle = TextStyle(fontFamily: "JosefinSans");

      titleController.text = note.metadata.title;
      contentController.text = note.metadata.content;

      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Titel",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            TextField(
              controller: contentController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Inhoud",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  //get the note from the db
  void _getNote(String id) {
    NoteApi.getNote(id).then(
      (result) {
        setState(() {
          note = result;
        });
      },
    );
  }

  ///Act on the selected menu item.
  void _menuSelected(String index) async {
    switch (index) {
      case "0":
        _saveNote();
        break;
      case "1":
        _deleteNote();
        break;
      case "2":
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  ///save the note before going back to the overview
  void _saveNote() {
    note.metadata.title = titleController.text;
    note.metadata.content = contentController.text;

    debugPrint("Saving");

    NoteApi.updateNote(id, note).then((result) {
      Navigator.pop(context, true);
    });
  }

  ///delete the note
  void _deleteNote() {
    NoteApi.deleteNote(id).then((result) {
      Navigator.pop(context, true);
    });
  }
}
