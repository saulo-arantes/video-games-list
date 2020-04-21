import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/pages/game-details/game-details.dart';
import 'package:video_games_list/utils/consts.dart';

class Search extends SearchDelegate<String> {
  final String searchFieldLabel = "Search games...";
  final scrollController = ScrollController();
  final LocalStorage storage = new LocalStorage('lastSearches');
  final GlobalKey loaderKey = new GlobalKey();

  SearchGames games;
  int pagination = 1;

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);

    assert(theme != null);

    return theme.copyWith(
      primaryColor: mainColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
      scaffoldBackgroundColor: mainColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54)
      ),
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(color: Colors.white),
      )
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          pagination = 1;
          games = new SearchGames();
          buildSuggestions(context);
        },
      ),

      IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () {
          storage.deleteItem("recentSearches");
          query = "";
          pagination = 1;
          games = new SearchGames();
          buildSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    games = new SearchGames(query: query);
    List<dynamic> recentSearches = storage.getItem("recentSearches");

    if (recentSearches == null) {
      recentSearches = new List<dynamic>();
    }

    recentSearches.add(query);

    List<dynamic> distinctRecentSearches = recentSearches.toSet().toList().reversed.toList();

    storage.setItem("recentSearches", distinctRecentSearches);

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          pagination++;
          print(pagination);
          games.loadMore(
            pagination: pagination
          );
        }
      }
    });
    games.search = query;

    return StreamBuilder(
      stream: games.stream,
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (!_snapshot.hasData) {
          return Container(
            color: mainColor,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              )
            ),
          );
        }

        return Container(
          color: mainColor,
          child: ListView.separated(
            controller: scrollController,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black38,
            ),
            itemCount: _snapshot.data.length + 1,
            itemBuilder: (BuildContext _context, int index) {
              if (index < _snapshot.data.length) {
                return ListTile(
                  title: Text(
                    _snapshot.data[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Baloo Paaji 2",
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    ),
                  ),
                  leading: Container(
                    width: width(context) * 0.2,
                    decoration: _snapshot.data[index].backgroundImage != null ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_snapshot.data[index].backgroundImage),
                        fit: BoxFit.cover
                      )
                    ) : BoxDecoration(),
                  ),
                  onTap: () {
                    close(context, query);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameDetailsPage(
                          game: _snapshot.data[index]
                        )
                      ),
                    );
                  },
                );
              } else if (games.hasMore) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(
                    key: loaderKey,
                    child: Container(
                      child: CircularProgressIndicator()
                    )
                  ),
                );
              }

              return Container(color: mainColor);
            }
          )
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          var data = storage.getItem('recentSearches');

          if (data != null) {
            return Container(
              color: mainColor,
              child: ListView.builder(
                itemCount: data != null ? data.length : 0,
                itemBuilder: (BuildContext _context, int index) {
                  return ListTile(
                    title: Text(
                      data[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onTap: () {
                      query = data[index];
                      showResults(context);
                    },
                  );
                },
              )
            );
          }

          return Container(color: mainColor);
        } else {
          return Container(
            width: width(context),
            height: height(context),
            color: mainColor
          );
        }
      },
    );
  }
}
