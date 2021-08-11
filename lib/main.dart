import 'package:flower_user_ui/dependency_injection.dart';
import 'package:flutter/material.dart';

import 'presentation/application.dart';

void main() {
  configureDependencies();
  runApp(Application());
}
