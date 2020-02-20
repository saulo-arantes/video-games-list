import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-dialog.dart';
import 'package:video_games_list/widgets/game-card-title.dart';

class GameCard extends StatelessWidget {
  final Game game;

  GameCard({this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 350.0,
        width: double.infinity,
        margin: gameCardMargin,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: NetworkImage(game.backgroundImage),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GameCardTitle(game: game)
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => GameCardDialog(game: game),
          barrierDismissible: true
        );
      },
    );
  }
}
