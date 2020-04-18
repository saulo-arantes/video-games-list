import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card/game-card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  Games games;
  int pagination = 1;

  @override
  void initState() {
    games = Games();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
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
        title: Text(
          "Last released games",
          style: header1Style,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
        bottom: AppBar(
          title: const Text("Released in last 30 days"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: games.stream,
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (!_snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              pagination = 1;
              return games.refresh();
            },
            child: ListView.separated(
              controller: scrollController,
              separatorBuilder: (context, index) => Divider(),
              itemCount: _snapshot.data.length + 1,
              itemBuilder: (BuildContext _context, int index) {
                if (index < _snapshot.data.length) {
                  return GameCard(game: _snapshot.data[index]);
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
                        onPressed: () {},
                      )
                    ),
                  );
                }
              }
            ),
          );
        },
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
