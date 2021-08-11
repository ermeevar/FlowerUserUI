import 'package:flower_user_ui/app/locator.dart';
import 'package:flower_user_ui/app/router.gr.dart';
import 'package:flower_user_ui/presentation/services/authorization_service.dart';
import 'package:flower_user_ui/presentation/services/theme_service.dart';
import 'package:flutter/material.dart' hide Router;

class ApplicationViewModel extends ChangeNotifier {
  final ThemeService themeService = locator.get();
  final AuthorizationService authorizationService = locator.get();
  final Router router = locator.get();

  Future<void> initialise() async {
    final isAuthorized = await authorizationService.isAuthorized();
    if (isAuthorized) {
      router.push(const NavigationMenuRoute());
    } else {
      router.push(const AuthorizationMainMenuRoute());
    }
  }
}
