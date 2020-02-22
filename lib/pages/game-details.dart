import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';
import 'package:video_games_list/widgets/game-card-title-platforms.dart';

class GameDetailsPage extends StatefulWidget {
  final String title;
  final String slug;

  GameDetailsPage({this.title, this.slug});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: header1Style,
          overflow: TextOverflow.ellipsis
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red.shade800,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            }
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getGame(slug: widget.slug),
          builder: (BuildContext _context, AsyncSnapshot _snapshot) {
            if (!_snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              );
            }

            final game = _snapshot.data;

            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            Dates.convert(date: game["released"]),
                            style: header3Style,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          child: GameCardTitlePlatforms(platforms: game["parent_platforms"]),
                        )
                      ],
                    )
                  ],
                ),
              )
            );
          },
        ),
      ),
    );
  }
}
