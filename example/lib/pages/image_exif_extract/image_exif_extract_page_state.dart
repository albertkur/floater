import 'package:example/services/media_service/media_service.dart';
import 'package:exif/exif.dart';
import 'package:floater/floater.dart';

import 'image_exif_extract_page.dart';

class ImageExifExtractPageState extends WidgetStateBase<ImageExifExtractPage> {
  final _mediaService = ServiceLocator.instance.resolve<MediaService>();
  ImageExifExtractPageState() : super();

  Future<void> uploadImage() async {
    final file = await this._mediaService.getImageFromGallery();
    print(file!.path);

    final data = await readExifFromFile(file);

    for (String key in data.keys) {
      print("$key (${data[key]!.tagType}): ${data[key]}");
    }
  }
}
