import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaService {
  Future<File?> getImageFromGallery(
      [ImageAspectRatio aspectRatio = ImageAspectRatio.square]) async {
    final hasPermissions = await this._checkGalleryPermissions();

    if (!hasPermissions) return null;

    final picker = ImagePicker();
    PickedFile? image;
    try {
      image = await picker.getImage(source: ImageSource.gallery);
      if (Platform.isAndroid && image == null) {
        image = await this._retrieveLostData(picker);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }

    if (image == null) return null;

    return File(image.path);

    // return await this.cropImage(File(image.path), aspectRatio);
  }

  Future<File?> cropImage(File image,
      [ImageAspectRatio aspectRatio = ImageAspectRatio.square]) async {
    CropAspectRatio ratio;
    if (aspectRatio == ImageAspectRatio.ratio16x9) {
      ratio = const CropAspectRatio(ratioX: 16, ratioY: 9);
    } else {
      ratio = const CropAspectRatio(ratioX: 1, ratioY: 1);
    }

    return ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: ratio,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 70,
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: ratio.ratioX / ratio.ratioY,
        showCancelConfirmationDialog: true,
        aspectRatioLockEnabled: true,
        showActivitySheetOnDone: false,
        resetAspectRatioEnabled: false,
        title: "Crop Image",
      ),
      androidUiSettings: AndroidUiSettings(
        lockAspectRatio: true,
        initAspectRatio: aspectRatio == ImageAspectRatio.ratio16x9
            ? CropAspectRatioPreset.ratio16x9
            : CropAspectRatioPreset.square,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
    );
  }

  Future<PickedFile?> _retrieveLostData(ImagePicker picker) async {
    final response = await picker.getLostData();
    if (response.isEmpty || response.file == null) {
      return null;
    }

    return response.file;
  }

  Future<bool> _checkGalleryPermissions() async {
    final permission = await Permission.photos.request();

    if (permission.isPermanentlyDenied) {
      await this._openSettings();

      return Permission.photos.status.isGranted;
    }

    return true;
  }

  Future<void> _openSettings() async {
    await openAppSettings();
  }
}

enum ImageAspectRatio {
  square,
  ratio16x9,
}
