import 'package:flutter/material.dart';
import 'package:floater/floater.dart';
import 'package:flutter/scheduler.dart';
import 'image_list_page_state.dart';

class ImageListPage extends StatefulWidgetBase<ImageListPageState> {
  ImageListPage() : super(() => ImageListPageState());
  @override
  Widget build(BuildContext context) {
    timeDilation = 3;
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "imageHero",
          child: InkWell(
            onTap: this.state.goToFullScreen,
            child: Image.network(
              "https://images.unsplash.com/photo-1554080353-a576cf803bda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGhvdG98ZW58MHx8MHx8&w=1000&q=80",
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
