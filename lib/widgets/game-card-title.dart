import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-title-platforms.dart';

class GameCardTitle extends StatelessWidget {
  final Game game;

  GameCardTitle({this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: gameCardTitlePadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(game.name, style: header3Style),

          GameCardTitlePlatforms(platforms: game.parentPlatforms),
        ],
      ),
    );
  }
}
