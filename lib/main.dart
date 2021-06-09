import 'package:flutter/material.dart';
import './pages/homepage.dart';

void main() => runApp(new StickyNotesApp());

class StickyNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AR sticky notes",
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}
