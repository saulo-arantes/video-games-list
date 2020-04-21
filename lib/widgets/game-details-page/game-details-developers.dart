import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsDevelopers extends StatelessWidget {
  final developers;

  GameDetailsDevelopers({this.developers});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Developers",
          style: TextStyle(
            fontFamily: "Baloo Paaji 2",
            color: Colors.black,
            fontSize: 28.0
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
          formatedDevelopers(),
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

  String formatedDevelopers() {
    if (developers != null) {
      return developers.map((developer) {
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
