import 'dart:math';

extension DoubleExtensions on double {
  double roundDouble(int places) {
    double mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}
