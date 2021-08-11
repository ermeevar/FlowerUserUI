import 'package:flower_user_ui/presentation/screens/navigation_menu.dart';
import 'package:flower_user_ui/presentation/services/authorization_service.dart';
import 'package:flower_user_ui/presentation/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'presentation/screens/authorization_widgets/authorization_main_menu.dart';

class Application extends StatelessWidget {
  final ThemeService themeService = GetIt.I.get();
  final AuthorizationService authorizationService = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.light,
      home: FutureBuilder<bool>(
        future: authorizationService.isAuthorized(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                body: Center(
                  child: Text(
                    "Загрузка...",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              );
            case ConnectionState.done:
              return snapshot.data!
                  ? NavigationMenu()
                  : AuthorizationMainMenu();
            case ConnectionState.none:
              return Scaffold(
                body: Center(
                  child: Text(
                    "Нет сети",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              );
            case ConnectionState.active:
              return Scaffold(
                body: Center(
                  child: Text(
                    "Загрузка...",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
