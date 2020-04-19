import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';
import 'package:video_games_list/widgets/game-card/game-card-title-platforms.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-released-platforms.dart';
import 'dart:ui' as ui;

class GameDetailsFirstPage extends StatefulWidget {
  final Game game;
  final PageController controller;

  GameDetailsFirstPage({this.game, this.controller});

  @override
  _GameDetailsFirstPageState createState() => _GameDetailsFirstPageState();
}

class _GameDetailsFirstPageState extends State<GameDetailsFirstPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      padding: EdgeInsets.only(
        bottom: height(context) * 0.20
      ),
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
              left: width(context) * 0.1
            ),
            color: Colors.white54,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: width(context) * 0.6,
                        child: Text(
                          widget.game.name,
                          style: TextStyle(
                            fontFamily: "Baloo Paaji 2",
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                      ),

                      Container(
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black87,
                          ),
                          onTap: () {
                            widget.controller.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                          },
                        )
                      )
                    ],
                  ),
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
          )
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
