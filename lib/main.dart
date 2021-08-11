import 'package:flower_user_ui/presentation/dependency_injection.dart';
import 'package:flutter/material.dart';

import 'application.dart';

void main() {
  DependencyInjection.init();
  runApp(Application());
}
