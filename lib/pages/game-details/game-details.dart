import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';
import 'package:video_games_list/widgets/game-card/game-card-title-platforms.dart';

class GameDetailsPage extends StatefulWidget {
  final Game game;

  GameDetailsPage({this.game});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.game.backgroundImage),
                fit: BoxFit.fitHeight
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: statusBarHeight(context)
                  ),
                  color: Colors.black26,
                  width: width(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: actionButtons()
                  )
                ),

                Container(
                  width: width(context),
                  padding: EdgeInsets.only(
                    right: width(context) * 0.1,
                    left: 15.0
                  ),
                  margin: EdgeInsets.only(
                    left: width(context) * 0.1,
                    bottom: height(context) * 0.20
                  ),
                  color: Colors.white54,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Text(
                              widget.game.name,
                              style: TextStyle(
                                fontFamily: "Baloo Paaji 2",
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),

                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            GameCardTitlePlatforms(platforms: widget.game.parentPlatforms)
                          ],
                        )
                      ),

                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              Dates.convert(date: widget.game.released),
                              style: TextStyle(
                                fontFamily: "Baloo Paaji 2",
                                fontSize: 14.0,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> actionButtons() {
    return [
      IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),

        onPressed: () {
          Navigator.pop(context);
        },
      ),

      IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      )
    ];
  }
}
