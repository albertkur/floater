import 'package:flutter/material.dart';
import 'package:floater/floater.dart';
import 'package:video_player/video_player.dart';
import 'full_screen_video_page_state.dart';

class FullScreenVideoPage extends StatefulWidgetBase<FullScreenVideoPageState> {
  final VideoPlayerController controller;
  FullScreenVideoPage(this.controller) : super(() => FullScreenVideoPageState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "videoHero",
            child: InkWell(
              onTap: this.state.exitFullScreen,
              child: AspectRatio(
                aspectRatio: this.controller.value.aspectRatio,
                child: VideoPlayer(
                  this.controller,
                ),
              ),
            ),
          ),
          Hero(
            tag: "vidScrubber",
            child: VideoProgressIndicator(
              this.controller,
              allowScrubbing: true,
            ),
          ),
        ],
      ),
    );
  }
}
