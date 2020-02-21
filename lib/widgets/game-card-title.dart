import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-dialog.dart';
import 'package:video_games_list/widgets/game-card-title-platforms.dart';

class GameCardTitle extends StatefulWidget {
  final Game game;

  GameCardTitle({this.game});

  @override
  _GameCardTitleState createState() => _GameCardTitleState();
}

class _GameCardTitleState extends State<GameCardTitle> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: gameCardTitlePadding,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.white],
          tileMode: TileMode.repeated,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(widget.game.name, style: header3WithshadowStyle, overflow: TextOverflow.ellipsis),
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (_) => GameCardDialog(game: widget.game),
                          barrierDismissible: true
                        );
                      },
                    ),
                  ],
                ),

                GameCardTitlePlatforms(platforms: widget.game.parentPlatforms),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.favorite_border,
              color: Colors.red.shade800,
              size: 30.0,
            ),
          )
        ],
      )
    );
  }
}
