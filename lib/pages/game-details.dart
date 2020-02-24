import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-about.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-carousel.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-genres.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-platforms.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-released-platforms.dart';

class GameDetailsPage extends StatefulWidget {
  final String title;
  final String slug;
  final List screenshots;

  GameDetailsPage({this.title, this.slug, this.screenshots});

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
                    GameDetailsReleasedPlatforms(game: game),

                    GameDetailsCarousel(screenshots: widget.screenshots),

                    GameDetailsAboult(about: game["description_raw"]),

                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GameDetailsPlatforms(platforms: game["platforms"]),
                              GameDetailsGenres(genres: game["genres"])
                            ],
                          )
                        ],
                      ),
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
