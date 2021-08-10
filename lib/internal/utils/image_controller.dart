import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

mixin ImageController {
  static final _picker = ImagePicker();

  static Future<Uint8List?> getImage({required ImageSource source}) async {
    return _picker.pickImage(source: source).then((pickedFile) {
      if (pickedFile != null) {
        File(pickedFile.path).readAsBytes();
      }
    });
  }
}
