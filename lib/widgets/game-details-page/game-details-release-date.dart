import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';

class GameDetailsReleaseDate extends StatelessWidget {
  final String releaseDate;

  GameDetailsReleaseDate({this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Release date", style: header3Style),
        Text(
          Dates.convert(date: releaseDate),
          style: defaultTextStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
