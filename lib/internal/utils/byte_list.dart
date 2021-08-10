import 'dart:convert';

import 'dart:typed_data';

class ByteList {
  static Uint8List? from(dynamic data) {
    if (data != null) {
      return base64.decode(data as String);
    }
  }
}
