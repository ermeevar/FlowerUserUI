import 'dart:math';

extension DoubleExtensions on double {
  double roundDouble(int places) {
    double mod = pow(10.0, places) as double;
    return ((this * mod).round().toDouble() / mod);
  }
}
