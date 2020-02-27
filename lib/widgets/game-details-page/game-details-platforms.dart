import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsPlatforms extends StatelessWidget {
  final platforms;

  GameDetailsPlatforms({this.platforms});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Platforms", style: header3Style),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            formatedPlatforms(),
            style: defaultTextStyle,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  String formatedPlatforms() {
    if (platforms != null) {
      return platforms.map((platform) {
        return platform["platform"]["name"];
      })
      .toString()
      .replaceAll("(", "")
      .replaceAll(")", "")
      .replaceAll(", ", "\n");
    }

    return " ";
  }
}
