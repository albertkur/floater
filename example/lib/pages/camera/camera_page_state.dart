import 'package:camera/camera.dart';
import 'package:floater/floater.dart';

import 'camera_page.dart';

class CameraPageState extends WidgetStateBase<CameraPage> {
  final List<CameraController> controllers = [];

  CameraPageState() : super() {
    this.onInitState(() {
      this._init();
    });

    this.onDispose(() {
      this.controllers.forEach((element) {
        element.dispose();
      });
    });
  }

  Future<void> _init() async {
    final cameras = await availableCameras();
    this.controllers.addAll(cameras.map((e) => CameraController(e, ResolutionPreset.max)));

    await this.controllers.first.initialize();
    await this.controllers.last.initialize();

    this.triggerStateChange();
  }
}
