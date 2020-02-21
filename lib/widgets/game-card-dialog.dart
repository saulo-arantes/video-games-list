import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-dialog-video.dart';

class GameCardDialog extends StatefulWidget {
  final Game game;

  GameCardDialog({this.game});

  @override
  _GameCardDialogState createState() => _GameCardDialogState();
}

class _GameCardDialogState extends State<GameCardDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FutureBuilder(
        future: getGame(slug: widget.game.slug),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (!_snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            );
          }

          final gameJson = _snapshot.data;

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 600.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  
                  Container(
                    decoration: circularBorder,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 5.0,
                      right: 5.0
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(gameJson["name"], style: header2Style, textAlign: TextAlign.center,),
                        Text("${gameJson["developers"][0]["name"]} | ${gameJson["released"]}", style: defaultTextStyleBold),
                      ],
                    ),
                  ),

                  GameCardDialogVideo(url: widget.game.clip["clip"], backgroundImage: gameJson["clip"]["preview"],),

                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: gameCardDialogDescription,
                        child: Text(
                          gameJson["description_raw"],
                          style: defaultTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0
                    ),
                    child: MaterialButton(
                      child: Text(
                        "View more about this game",
                        style: defaultTextStyle,
                      ),
                      minWidth: double.infinity,
                      color: Colors.grey.shade800,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
