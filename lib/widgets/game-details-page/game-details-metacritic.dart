import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsMetacritic extends StatelessWidget {
  final int metacritic;

  GameDetailsMetacritic({this.metacritic});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Metascore", style: header3Style),
        metacritic != null
        ? Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: metascoreColor()
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: Text(
            metacritic.toString(),
            style: TextStyle(
              fontSize: 14.0,
              color: metascoreColor()
            ),
            textAlign: TextAlign.center,
          ),
        )
        : Container(
          child: Text("-", style: defaultTextStyle),
        )
      ],
    );
  }

  Color metascoreColor() {
    if (metacritic >= 80) {
      return Colors.green;
    }

    if (metacritic <= 40) {
      return Colors.red;
    }

    return Colors.orange;
  }
}
