import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GameCardVideo extends StatefulWidget {
  final String url;

  GameCardVideo({this.url});

  @override
  _GameCardVideoState createState() => _GameCardVideoState();
}

class _GameCardVideoState extends State<GameCardVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.url)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Center(
                child: CircularProgressIndicator(
                  value: null,
                  semanticsLabel: "Loading video...",
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white
                  ),
                ),
              ),

            _controller.value.initialized
              ? FlatButton(
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 34.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  }
                )
              : Container()
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
