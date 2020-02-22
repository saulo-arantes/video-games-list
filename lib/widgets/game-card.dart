import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/pages/game-details.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-title.dart';
import 'package:video_games_list/widgets/game-card-video.dart';

class GameCard extends StatefulWidget {
  final Game game;

  GameCard({this.game});

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  final double cardHeight = 350.0;
  
  int state = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      width: double.infinity,
      margin: gameCardMargin,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
          image: NetworkImage(widget.game.backgroundImage),
          fit: BoxFit.cover
        )
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      state == 1 ? Colors.transparent : Colors.white,
                      Colors.transparent
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)
                  )
                ),
                width: double.infinity,
                height: 60.0,
                child: GestureDetector(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 40.0,
                    color: state == 1 ? Colors.transparent : Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      state = 1;
                    });
                  },
                ),
              ),
              state == 0 ? GameCardTitle(game: widget.game) : Container()
            ],
          ),

          state == 1 
            ? Container(
              height: state == 1 ? cardHeight : 0,
              width: double.infinity,
              padding: EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.black87
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.game.name,
                        style: header2Style,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis
                      ),
                      Text(
                        "Released at: " + (widget.game.released ?? "-"), 
                        style: defaultTextStyleBold
                      ),
                      Text(
                        widget.game.genres.map((genre) {
                          return genre["name"];
                        }).toString(),
                        style: defaultTextStyle,
                      ),
                      MaterialButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            SizedBox(width: 5.0),
                            Text("More info", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GameDetailsPage(
                              title: widget.game.name,
                              slug: widget.game.slug,
                              screenshots: widget.game.screenshots,
                            )),
                          );
                        },
                      )
                    ],
                  ),

                  GameCardVideo(
                    url: widget.game.clip["clip"],
                  ),

                  GestureDetector(
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    onTap: () {
                      setState(() {
                        state = 0;
                      });
                    },
                  )
                ],
              ),
            )
          : Container()
        ],
      ),
    );
  }
}
