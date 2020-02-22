import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';
import 'package:video_games_list/widgets/game-card-title-platforms.dart';

class GameDetailsReleasedPlatforms extends StatelessWidget {
  final game;

  GameDetailsReleasedPlatforms({this.game});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
            Dates.convert(date: game["released"]),
            style: header3Style,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: GameCardTitlePlatforms(platforms: game["parent_platforms"]),
        )
      ],
    );
  }
}