import 'package:flutter/material.dart';

//models
import '../models/note.dart';

//widgets
import './button.dart';

class AddNoteWidget extends StatefulWidget {
  @override
  _AddNoteWidgetState createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Notitie toevoegen",
        style: TextStyle(
          fontFamily: "AmaticSC",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //the title of the note
          TextField(
            controller: titleController,
            style: TextStyle(fontFamily: "JosefinSans"),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Titel",
              labelStyle: TextStyle(fontFamily: "JosefinSans"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Container(
            height: 15,
          ),
          //the content of the note
          TextField(
            controller: contentController,
            style: TextStyle(fontFamily: "JosefinSans"),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Inhoud",
              labelStyle: TextStyle(fontFamily: "JosefinSans"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Container(
            height: 15,
          ),
        ],
      ),
      actions: [
        ButtonWidget(
          text: "Sluit",
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ButtonWidget(
          text: "Sla op",
        )
      ],
    );
  }
}
