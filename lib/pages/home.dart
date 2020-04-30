import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card/game-card.dart';
import 'package:video_games_list/widgets/home/featured-game.dart';
import 'package:video_games_list/widgets/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageScrollController = ScrollController();
  final listScrollController = ScrollController();

  Game featuredGame;
  Games games;
  int pagination = 1;

  @override
  void initState() {
    games = Games();
    pageScrollController.addListener(() {
      if (pageScrollController.position.maxScrollExtent == pageScrollController.offset) {
        print("pagination");
        pagination++;
        games.loadMore(
          pagination: pagination
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          )
        ],
      ),
      drawer: Drawer(),
      backgroundColor: mainColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: pageScrollController,
        child: RefreshIndicator(
          onRefresh: () {
            pagination = 1;
            return games.refresh();
          },
          child: Container(
            width: width(context),
            child: StreamBuilder(
              stream: games.stream,
              builder: (BuildContext _context, AsyncSnapshot _snapshot) {
                if (_snapshot.hasData) {
                  final List<Game> gamesData = _snapshot.data;

                  if (featuredGame == null) {
                    final Random _random = new Random();

                    featuredGame = gamesData[_random.nextInt(gamesData.length)];
                    gamesData.removeWhere((item) => item.slug == featuredGame.slug);
                  }

                  return Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        HomeFeaturedGameWidget(featuredGame),

                        Container(
                          width: width(context),
                          margin: EdgeInsets.only(top: 15.0),
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "More games for you",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              height: 1.2
                            )
                          ),
                        ),

                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            controller: listScrollController,
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: gamesData.length + 1,
                            itemBuilder: (BuildContext _context, int index) {
                              if (index < gamesData.length) {
                                return GameCard(game: gamesData[index]);
                              } else if (games.hasMore) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32.0),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32.0),
                                  child: Center(
                                    child: MaterialButton(
                                      child: Text('Search for more games', style: defaultTextStyle,),
                                      color: Colors.grey.shade800,
                                      onPressed: () {
                                        showSearch(context: context, delegate: Search());
                                      },
                                    )
                                  ),
                                );
                              }
                            }
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return _loadingIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Container(
      height: height(context),
      width: width(context),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
