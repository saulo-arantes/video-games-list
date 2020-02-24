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
        Text("Publishers", style: header3Style),
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          child: Text(
            formatedPublishers(),
            style: defaultTextStyle,
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
