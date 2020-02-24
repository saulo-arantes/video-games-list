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
        Text("Developers", style: header3Style),
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          child: Text(
          formatedDevelopers(),
          style: defaultTextStyle,
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
