import 'package:flower_user_ui/dependency_injection.dart';
import 'package:flower_user_ui/presentation/screens/navigation_menu.dart';
import 'package:flower_user_ui/presentation/services/authorization_service.dart';
import 'package:flower_user_ui/presentation/services/theme_service.dart';
import 'package:flutter/material.dart';

import 'screens/authorization_widgets/authorization_main_menu.dart';

class Application extends StatelessWidget {
  final ThemeService themeService = getIt.get();
  final AuthorizationService authorizationService = getIt.get();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.light,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<bool>(
          future: authorizationService.isAuthorized(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingView();
              case ConnectionState.done:
                return snapshot.data!
                    ? NavigationMenu()
                    : AuthorizationMainMenu();
              case ConnectionState.none:
                return const NoConnectionView();
              case ConnectionState.active:
                return const LoadingView();
            }
          },
        ),
      ),
    );
  }
}

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Нет сети",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          Text(
            "Загрузка...",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
