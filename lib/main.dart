import 'package:flutter/material.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';
import 'presentation/application.dart';

void main() {
  configureDependencies();

  locator.registerSingleton(AppRouter());

  runApp(ApplicationView());
}
