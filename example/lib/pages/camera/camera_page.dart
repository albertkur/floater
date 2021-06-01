import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:floater/floater.dart';

import 'camera_page_state.dart';

class CameraPage extends StatefulWidgetBase<CameraPageState> {
  CameraPage() : super(() => CameraPageState());
  @override
  Widget build(BuildContext context) {
    return this.state.controllers.isEmpty
        ? Text("Camera not found")
        : ListView.builder(
            itemCount: this.state.controllers.length,
            itemBuilder: (context, index) {
              return CameraPreview(
                this.state.controllers[index],
                child: Text(
                  this.state.controllers[index].description.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            },
          );
  }
}
