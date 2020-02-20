import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GameCardDialogVideo extends StatefulWidget {
  final String url;

  GameCardDialogVideo({this.url});

  @override
  _GameCardDialogVideoState createState() => _GameCardDialogVideoState();
}

class _GameCardDialogVideoState extends State<GameCardDialogVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
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
