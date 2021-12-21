import 'package:flutter/material.dart';
import 'package:floater/floater.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'full_screen_image_page_state.dart';

class FullScreenImagePage extends StatefulWidgetBase<FullScreenImagePageState> {
  // final imageUrl =
  //     "https://images.unsplash.com/photo-1554080353-a576cf803bda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGhvdG98ZW58MHx8MHx8&w=1000&q=80";

  // final imageUrl = "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg";

  // final imageUrl =
  //     "https://media.istockphoto.com/photos/closeup-of-red-cricket-ball-and-bat-sitting-on-grass-picture-id177427917?k=20&m=177427917&s=612x612&w=0&h=kr-FOxME8KOnnhYsuR6WFAfB-Hv_ch20Fz5xnzeSU10=";
  final imageUrl =
      "https://media.istockphoto.com/photos/colored-powder-explosion-on-black-background-picture-id1057506940?k=20&m=1057506940&s=612x612&w=0&h=3j5EA6YFVg3q-laNqTGtLxfCKVR3_o6gcVZZseNaWGk=";
  FullScreenImagePage() : super(() => FullScreenImagePageState());

  @override
  Widget build(BuildContext context) {
    var image = Image.network(
      this.imageUrl,
      width: MediaQuery.of(context).size.width,
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ValueListenableBuilder<double>(
                valueListenable: this.state.backGroundOpacity,
                child: Container(
                  color: this.state.paletteGenerator?.vibrantColor?.color ?? Colors.black,
                ),
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child!);
                }),
          ),
          Center(
            child: Draggable(
              axis: Axis.vertical,
              onDragStarted: () {
                print("Drag started");
              },
              onDragUpdate: this.state.onDragUpdate,
              onDragEnd: this.state.onDragEnd,
              feedback: VisibilityDetector(
                  key: ValueKey("image"),
                  onVisibilityChanged: (VisibilityInfo info) {
                    print(info.visibleFraction);
                    if (info.visibleFraction < 0.5 && info.visibleFraction != 0) this.state.exitFullScreen();
                  },
                  child: image),
              childWhenDragging: SizedBox(),
              child: Hero(
                tag: "imageHero",
                child: InkWell(
                  onTap: this.state.exitFullScreen,
                  child: image,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
