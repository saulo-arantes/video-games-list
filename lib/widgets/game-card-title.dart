import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameCardTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: gameCardTitlePadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Sekiro: Shadows Die Twice", style: header3Style)
        ],
      ),
    );
  }
}
