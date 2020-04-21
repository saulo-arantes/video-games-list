import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';
import 'package:video_games_list/widgets/game-card/game-card-title-platforms.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-about.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-carousel.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-developers.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-genres.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-metacritic.dart';
import 'package:video_games_list/widgets/game-details-page/game-details-publishers.dart';

class GameDetailsPage extends StatefulWidget {
  final Game game;

  GameDetailsPage({this.game});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: "gamedetails",
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.game.backgroundImage),
                    fit: BoxFit.fitHeight
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: statusBarHeight(context)
                      ),
                      color: Colors.black26,
                      width: width(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // children: actionButtons()
                      )
                    ),

                    Container(
                      width: width(context),
                      padding: EdgeInsets.only(
                        right: width(context) * 0.1,
                        left: 15.0,
                        top: 15.0
                      ),
                      margin: EdgeInsets.only(
                        left: width(context) * 0.1,
                        bottom: height(context) * 0.20
                      ),
                      color: Colors.white54,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.game.name,
                                  style: TextStyle(
                                    fontFamily: "Baloo Paaji 2",
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    height: 1.2
                                  ),
                                ),
                              )
                            ],
                          ),

                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                GameCardTitlePlatforms(platforms: widget.game.parentPlatforms)
                              ],
                            )
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      Dates.convert(date: widget.game.released),
                                      style: TextStyle(
                                        fontFamily: "Baloo Paaji 2",
                                        fontSize: 14.0,
                                        color: Colors.black
                                      ),
                                    )
                                  ],
                                )
                              ),

                              FlatButton(
                                child: Text(
                                  "See more...",
                                  style: TextStyle(
                                    fontFamily: "Baloo Paaji 2",
                                    fontSize: 14.0,
                                    color: Colors.black
                                  ),
                                ),
                                onPressed: () {
                                  _showModalWithMoreInfo();
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> actionButtons() {
    return [
      IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),

        onPressed: () {
          Navigator.pop(context);
        },
      ),

      IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      )
    ];
  }

  void _showModalWithMoreInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: height(context) * 0.8,
        child: FutureBuilder(
          future: getGame(slug: widget.game.slug),
          builder: (BuildContext _context, AsyncSnapshot _snapshot) {
            if (_snapshot.hasData) {
              final Map game = _snapshot.data;

              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      GameDetailsAboult(about: game["description_raw"]),

                      SizedBox(height: 15.0),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GameDetailsDevelopers(developers: game["developers"]),
                          GameDetailsPublishers(publishers: game["publishers"])
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GameDetailsGenres(genres: game["genres"]),
                          GameDetailsMetacritic(metacritic: game["metacritic"])
                        ],
                      ),

                      GameDetailsCarousel(screenshots: widget.game.screenshots),

                      SizedBox(height: 15.0)
                    ],
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        )
      )
    );
  }
}
