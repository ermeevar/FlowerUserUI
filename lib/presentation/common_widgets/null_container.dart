import 'package:flutter/cupertino.dart';

// HACK: Бесполезная в целом вещь, стоит убрать а в коде сделать if () widget;

Widget nullContainer() {
  return const SizedBox(
    height: 0,
    width: 0,
  );
}
