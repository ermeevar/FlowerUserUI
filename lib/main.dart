import 'package:flutter/material.dart' hide Router;

import 'app/locator.dart';
import 'app/router.gr.dart';
import 'presentation/application.dart';

void main() {
  configureDependencies();

  locator.registerSingleton(Router());

  runApp(ApplicationView());
}
