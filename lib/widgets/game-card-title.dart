import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-dialog.dart';
import 'package:video_games_list/widgets/game-card-title-platforms.dart';

class GameCardTitle extends StatelessWidget {
  final Game game;

  GameCardTitle({this.game});

  @override
  Widget build(BuildContext context) {
    print(game.rating);
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
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(game.name, style: header3WithshadowStyle, overflow: TextOverflow.ellipsis),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => GameCardDialog(game: game),
                          barrierDismissible: true
                        );
                      },
                    ),
                  ],
                ),

                GameCardTitlePlatforms(platforms: game.parentPlatforms),
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
