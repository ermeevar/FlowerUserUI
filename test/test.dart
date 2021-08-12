import 'package:flower_user_ui/internal/utils/path.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Util tests", () {
    test('getFullname test', () async {
      const fullPath = "/home/data/photo.jpg";
      assert(Path.getFilename(fullPath) == "photo");
    });
  });
}
