import 'package:flutter/material.dart';
import 'package:floater/floater.dart';
import 'full_screen_image_page_state.dart';

class FullScreenImagePage extends StatefulWidgetBase<FullScreenImagePageState> {
  FullScreenImagePage() : super(() => FullScreenImagePageState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "imageHero",
          child: InkWell(
            onTap: this.state.exitFullScreen,
            child: Image.network(
              "https://images.unsplash.com/photo-1554080353-a576cf803bda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGhvdG98ZW58MHx8MHx8&w=1000&q=80",
            ),
          ),
        ),
      ),
    );
  }
}
