import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameDetailsGenres extends StatelessWidget {
  final genres;

  GameDetailsGenres({this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Genres",
          style: TextStyle(
            fontFamily: "Baloo Paaji 2",
            color: Colors.black,
            fontSize: 28.0
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            formatedGenres(),
            style: TextStyle(
              fontFamily: "Baloo Paaji 2",
              color: Colors.black,
              fontSize: 16.0,
              height: 1.3
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  String formatedGenres() {
    if (genres != null) {
      return genres.map((genre) {
        return genre["name"];
      })
      .toString()
      .replaceAll("(", "")
      .replaceAll(")", "")
      .replaceAll(", ", "\n");
    }

    return " ";
  }
}
