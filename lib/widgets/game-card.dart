import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-dialog.dart';
import 'package:video_games_list/widgets/game-card-title.dart';

class GameCard extends StatelessWidget {
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
            image: NetworkImage("https://media.rawg.io/media/games/b1c/b1c27510817af1ad7d23494e07822777.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GameCardTitle()
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => GameCardDialog(),
          barrierDismissible: true
        );
      },
    );
  }
}
