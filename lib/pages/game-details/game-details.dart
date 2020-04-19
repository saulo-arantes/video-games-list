import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/pages/game-details/game-details-first-page.dart';
import 'package:video_games_list/pages/game-details/game-details-second-page.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsPage extends StatefulWidget {
  final Game game;

  GameDetailsPage({this.game});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  bool isFavorite = false;
  final PageController controller = new PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        child: PageView(
          controller: controller,
          children: <Widget>[
            GameDetailsFirstPage(
              game: widget.game,
              controller: controller
            ),
            GameDetailsSecondPage(),
          ],
        ),
      ),
    );
  }
}
