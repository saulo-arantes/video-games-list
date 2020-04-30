import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/pages/game-details/game-details.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card/game-card-title.dart';

class GameCard extends StatefulWidget {
  final Game game;

  GameCard({this.game});

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  final double cardHeight = 350.0;

  int state = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailsPage(
              game: widget.game
            )
          ),
        );
      },
      child: Container(
        height: cardHeight,
        width: double.infinity,
        margin: gameCardMargin,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: Colors.transparent
          ),
          image: DecorationImage(
            image: NetworkImage(widget.game.backgroundImage),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GameCardTitle(game: widget.game)
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
