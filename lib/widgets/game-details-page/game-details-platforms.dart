import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsPlatforms extends StatelessWidget {
  final platforms;

  GameDetailsPlatforms({this.platforms});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Platforms", style: header3Style),
                  Text(
                    formatedPlatform(),
                    style: defaultTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  String formatedPlatform() {
    return platforms.map((platform) {
      return platform["platform"]["name"];
    })
    .toString()
    .replaceAll("(", "")
    .replaceAll(")", "")
    .replaceAll(", ", ",\n");
  }
}
