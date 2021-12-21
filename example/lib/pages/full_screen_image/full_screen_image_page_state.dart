import 'package:example/services/bottom_nav_manager_mixin.dart';
import 'package:floater/floater.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'full_screen_image_page.dart';

class FullScreenImagePageState extends WidgetStateBase<FullScreenImagePage> with BottomNavManagerMixin {
  final _minOpacity = 0.5;
  final _maxOpacity = 1.0;
  final _minDistance = 50;
  final _maxDistance = 300;
  bool _isExited = false;

  double _distanceMovedFromOrigin = 0;

  PaletteGenerator? paletteGenerator;

  ValueNotifier<double> backGroundOpacity = ValueNotifier(1);

  FullScreenImagePageState() : super() {
    this.onInitState(() async {
      this.paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(this.widget.imageUrl),
      );

      // this.background = paletteGenerator.vibrantColor?.color ?? paletteGenerator.dominantColor?.color;
      this.triggerStateChange();
    });
    // updating interval so that when erratically scrolling the video visibility is still reported
    final defaultVisibilityInterval = VisibilityDetectorController.instance.updateInterval;
    VisibilityDetectorController.instance.updateInterval = const Duration(milliseconds: 100);

    this.onDispose(() {
      VisibilityDetectorController.instance.updateInterval = defaultVisibilityInterval;
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    // print("next");
    // print(details.delta.direction);
    // print(details.delta.dx);
    // print(details.delta.dy);
    // print(details.delta.distance);
    this._distanceMovedFromOrigin += details.delta.dy;
    print(this._distanceMovedFromOrigin);

    if (this._distanceMovedFromOrigin < this._minDistance) {
      this.backGroundOpacity.value = 1;
      return;
    }

    if (this._distanceMovedFromOrigin > this._maxDistance) {
      this.backGroundOpacity.value = 0.5;
      return;
    }

    // final normalizedValue = this._minOpacity +
    //     ((this._distanceMovedFromOrigin.abs() - this._minDistance) *
    //         (this._maxOpacity - this._minOpacity) /
    //         (this._maxDistance - this._minDistance));
    final normalizedValue = this._maxOpacity +
        ((this._distanceMovedFromOrigin.abs() - this._minDistance) *
            (this._minOpacity - this._maxOpacity) /
            (this._maxDistance - this._minDistance));
    print(normalizedValue);
    this.backGroundOpacity.value = normalizedValue;
    // if (details.delta.distance > 60) {
    //   this.state.exitFullScreen();
    // }
  }

  void onDragEnd(DraggableDetails details) {
    this._distanceMovedFromOrigin = 0;
    this.backGroundOpacity.value = 1;

    print(details.velocity.pixelsPerSecond);
    if (details.velocity.pixelsPerSecond.distance > 500) {
      this.exitFullScreen();
    }
  }

  void exitFullScreen() {
    if (this._isExited) return;
    // this.currentNavigator.pop();
    this._isExited = true;
  }
}
