import 'dart:io';
import 'package:flower_user_ui/presentation/screens/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'internal/utils/certificate.dart';
import 'presentation/screens/authorization_widgets/authorization_main_menu.dart';

void main() {
  HttpOverrides.global = new Certificate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> isAuthorized() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getInt('AccountId') == null || prefs.getInt('AccountId') == 0)
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 15,
                fontFamily: "SourceSansPro",
                color: Colors.black,
                decoration: TextDecoration.none),
            bodyText2: TextStyle(
                fontSize: 15,
                fontFamily: "SourceSansPro",
                color: Colors.white,
                decoration: TextDecoration.none),
            headline6: TextStyle(
                fontSize: 25,
                fontFamily: "Philosopher",
                color: Colors.white,
                decoration: TextDecoration.none),
            subtitle2: TextStyle(
                fontSize: 23,
                fontFamily: "Philosopher",
                color: Color.fromRGBO(110, 53, 76, 1),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Color.fromRGBO(110, 53, 76, 1),
            actionTextColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: Color.fromRGBO(130, 147, 153, 1),
              ),
              contentPadding: EdgeInsets.zero,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromRGBO(130, 147, 153, 1),
              ))),
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Color.fromRGBO(130, 147, 153, 1),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))))),
      home: FutureBuilder<bool>(
          future: isAuthorized(),
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
                return snapshot.data
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
          }),
    );
  }
}
