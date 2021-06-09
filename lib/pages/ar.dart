import 'package:flutter/material.dart';
import '../widgets/arstickynotes.dart';

//widgets
import '../widgets/add-note.dart';

class ArNotePage extends StatefulWidget {
  @override
  _ArNotePageState createState() => _ArNotePageState();
}

class _ArNotePageState extends State<ArNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notities maken",
          style: TextStyle(
              fontSize: 40.0,
              fontFamily: "AmaticSC",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ArStickynotesWidget(),
      ),
    );
  }
}
