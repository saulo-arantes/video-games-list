import 'package:flutter/material.dart';
import 'package:video_games_list/models/games.dart';
import 'package:video_games_list/pages/game-details/game-details.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/utils/dates.dart';

class HomeFeaturedGameWidget extends StatefulWidget {
  final Game game;

  HomeFeaturedGameWidget(this.game);

  @override
  _HomeFeaturedGameWidgetState createState() => _HomeFeaturedGameWidgetState();
}

class _HomeFeaturedGameWidgetState extends State<HomeFeaturedGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Container(
          height: height(context) * 0.45,
          child: ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 1],
              colors: [Colors.black, Colors.transparent]
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
            blendMode: BlendMode.dstIn,
            child: Hero(
              tag: "gamedetails",
              child: Image.network(
                widget.game.backgroundImage,
                fit: BoxFit.cover,
              ),
            )
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 20.0,
            left: 15.0,
            right: 15.0
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width(context),
                child: Text(
                  widget.game.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    height: 1.2
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    Dates.convert(date: widget.game.released),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      height: 1.2
                    ),
                  ),

                  FlatButton(
                    child: Text(
                      "See more...",
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        height: 1.2
                      ),
                    ),
                    highlightColor: Colors.white12,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameDetailsPage(
                            game: widget.game
                          )
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          )
        )
      ],
    );
  }
}
