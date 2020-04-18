import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:video_games_list/models/games.dart';

class Search extends SearchDelegate<String> {
  final String searchFieldLabel = "Buscar";
  SearchGames games;
  final scrollController = ScrollController();
  final LocalStorage storage = new LocalStorage('lastSearches');
  int pagination = 1;

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
    storage.setItem("recentSearches", recentSearches);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        pagination++;
        games.loadMore(
          pagination: pagination
        );
      }
    });
    games.search = query;

    return StreamBuilder(
      stream: games.stream,
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (!_snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
          );
        }

        return ListView.separated(
          controller: scrollController,
          separatorBuilder: (context, index) => Divider(),
          itemCount: _snapshot.data.length + 1,
          itemBuilder: (BuildContext _context, int index) {
            if (index < _snapshot.data.length) {
              return ListTile(
                title: Text(_snapshot.data[index].name),
              );
            } else if (games.hasMore) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return Container();
          }
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
            return ListView.builder(
              itemCount: data != null ? data.length : 0,
              itemBuilder: (BuildContext _context, int index) {
                return ListTile(
                  title: Text(data[index]),
                  onTap: () {
                    query = data[index];
                    showResults(context);
                  },
                );
              },
            );
          }

          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
