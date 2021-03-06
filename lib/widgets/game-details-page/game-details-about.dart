import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsAboult extends StatefulWidget {
  final String about;

  GameDetailsAboult({this.about});

  @override
  _GameDetailsAboultState createState() => _GameDetailsAboultState();
}

class _GameDetailsAboultState extends State<GameDetailsAboult> {
  bool trim = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 15.0,
        left: 10.0,
        right: 10.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              "About",
              style: gameDetailsHeaderStyle,
              textAlign: TextAlign.left
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 5.0),
            width: double.infinity,
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.clip,
              text: TextSpan(
                text: widget.about,
                style: gameDetailsTextStyle
              )
            ),
          ),
        ],
      ),
    );
  }
}
