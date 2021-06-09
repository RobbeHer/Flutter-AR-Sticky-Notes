import 'package:flutter/material.dart';

//widgets
import '../widgets/button.dart';
//apis
import 'package:stickyNotes/apis/note_api.dart';
//models
import 'package:stickyNotes/models/note.dart';
//pages
import 'package:stickyNotes/pages/note_edit.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<Note> noteList = List<Note>();
  int count = 0;
  String imgBaseUrl = "https://s3-eu-west-1.amazonaws.com/target-manager-live/b6f110e82185e3b6917e420f9ff5ba28/5fefa2afc48140645bbb3a0f/";

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Overzicht",
          style: TextStyle(
              fontSize: 40.0,
              fontFamily: "AmaticSC",
              fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(25.0),
          child: _noteListItems()),
    );
  }

  _noteListItems() {
    if (noteList.isEmpty)
      return Center(child: CircularProgressIndicator());
    else {
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Image(
                image: NetworkImage(imgBaseUrl + this.noteList[position].metadata.imgId + "/thumb.jpeg"),
              ),
              title: Text(
                noteList[position].metadata.title,
                style: TextStyle(fontFamily: "JosefinSans"),
              ),
              trailing: Wrap(
                spacing: 1,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _onEditPressed(this.noteList[position].id);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      _onDeleteButtonPressed(this.noteList[position].id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void _getNotes() {
    NoteApi.getNotes().then((result) {
      setState(() {
        noteList = result;
        count = result.length;
      });
    });
  }

  void _onDeleteButtonPressed(String id) {
    NoteApi.deleteNote(id).then((result) {
      _getNotes();
    });
  }

  void _onEditPressed(String id) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditPage(id)),
    );
    if (result == true) _getNotes();
  }
}
