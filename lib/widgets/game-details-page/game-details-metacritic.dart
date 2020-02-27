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
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              metacritic.toString(),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                color: metascoreColor()
              ),
              textAlign: TextAlign.center,
            )
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text("-", style: defaultTextStyle, textAlign: TextAlign.center),
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
