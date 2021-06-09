import 'package:flutter/material.dart';

//pages
import './overview.dart';
import './ar.dart';
//widgets
import '../widgets/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
              fontSize: 40.0,
              fontFamily: "AmaticSC",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            Text(
              "Welkom",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 40.0,
                  fontFamily: "AmaticSC",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Welkom, in deze app kunt u makkelijk notities opslaan en bekijken in AR. U kunt hieronder de knop vinden om naar de AR omgeving te gaan of om een overzicht van alle notities te bekijken.",
              style: TextStyle(
                fontFamily: "JosefinSans",
                fontWeight: FontWeight.w300,
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  ButtonWidget(
                    text: "Naar AR",
                    onButtonPressed: () {
                      _onArButtonPressed(context);
                    },
                  ),
                  ButtonWidget(
                    text: "Naar notitie overzicht",
                    onButtonPressed: () {
                      _onOverviewPressed(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onArButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArNotePage(),
      ),
    );
  }

  _onOverviewPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverviewPage(),
      ),
    );
  }
}
