import 'package:flutter/material.dart';
import 'package:floater/floater.dart';

import 'image_exif_extract_page_state.dart';

class ImageExifExtractPage extends StatefulWidgetBase<ImageExifExtractPageState> {
  ImageExifExtractPage() : super(() => ImageExifExtractPageState());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: this.state.uploadImage,
            child: Text("Upload Image"),
          ),
        ],
      ),
    );
  }
}
