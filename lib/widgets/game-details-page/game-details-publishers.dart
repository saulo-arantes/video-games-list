import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsPublishers extends StatelessWidget {
  final publishers;

  GameDetailsPublishers({this.publishers});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Publishers", style: TextStyle(
            fontFamily: "Baloo Paaji 2",
            color: Colors.black,
            fontSize: 28.0
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          child: Text(
            formatedPublishers(),
            style: TextStyle(
              fontFamily: "Baloo Paaji 2",
              color: Colors.black,
              fontSize: 16.0,
              height: 1.3
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  String formatedPublishers() {
    if (publishers != null) {
      return publishers.map((developer) {
        return developer["name"];
      })
      .toString()
      .replaceAll("(", "")
      .replaceAll(")", "")
      .replaceAll(", ", ",\n");
    }

    return " ";
  }
}
