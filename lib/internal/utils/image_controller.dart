import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

mixin ImageController {
  static final _picker = ImagePicker();

  static Future<Uint8List?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path).readAsBytes();
    }
  }

  static Future<Uint8List?> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path).readAsBytes();
    }
  }
}
