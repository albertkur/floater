import 'package:flutter/material.dart';
import 'package:floater/floater.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';
import 'image_list_page_state.dart';

class ImageListPage extends StatefulWidgetBase<ImageListPageState> {
  ImageListPage() : super(() => ImageListPageState());
  @override
  Widget build(BuildContext context) {
    // timeDilation = 3; // TODO: to see animation slowly
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "imageHero",
            child: InkWell(
              onTap: this.state.goToFullScreenImage,
              child: Image.network(
                "https://images.unsplash.com/photo-1554080353-a576cf803bda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGhvdG98ZW58MHx8MHx8&w=1000&q=80",
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: this.state.controller.value.isInitialized
                ? Hero(
                    tag: "videoHero",
                    child: InkWell(
                      onTap: this.state.goToFullScreenVideo,
                      child: AspectRatio(
                        aspectRatio: this.state.controller.value.aspectRatio,
                        child: VideoPlayer(
                          this.state.controller,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          Hero(
            tag: "vidScrubber",
            child: VideoProgressIndicator(
              this.state.controller,
              allowScrubbing: true,
            ),
          ),
        ],
      ),
    );
  }
}
