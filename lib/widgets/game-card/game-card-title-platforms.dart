import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';

class GameCardTitlePlatforms extends StatelessWidget {
  final List platforms;

  GameCardTitlePlatforms({this.platforms});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: platformsWidgets(),
      ),
    );
  }

  List<Widget> platformsWidgets() {
    return List<Widget>.generate(platforms.length, (int index) {
      return platformsMap[platforms[index]['platform']['slug']] != null
        ? Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : 5.0,
            right: 5.0,
            top: 5.0
          ),
          child: Image.asset(
            platformsMap[platforms[index]['platform']['slug']],
            height: 20.0,
          )
      )
      : Container();
    });
  }
}
