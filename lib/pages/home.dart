import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending",
          style: header1Style,
        ),
        bottom: AppBar(
          title: const Text("Based on player counts and release date"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            GameCard(),

            GameCard(),

            GameCard(),
          ],
        )
      ),
    );
  }
}
