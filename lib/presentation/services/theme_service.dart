import 'package:flower_user_ui/presentation/utils/assets.gen.dart';
import 'package:flower_user_ui/internal/utils/path.dart';
import 'package:flutter/material.dart';

class ThemeService {
  ThemeData get light => ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 15,
              fontFamily: Path.getFilename(Assets.fonts.sourceSansPro),
              color: Colors.black,
              decoration: TextDecoration.none),
          bodyText2: TextStyle(
              fontSize: 15,
              fontFamily: Path.getFilename(Assets.fonts.sourceSansPro),
              color: Colors.white,
              decoration: TextDecoration.none),
          headline6: TextStyle(
              fontSize: 25,
              fontFamily: Path.getFilename(Assets.fonts.philosopher),
              color: Colors.white,
              decoration: TextDecoration.none),
          subtitle2: TextStyle(
              fontSize: 23,
              fontFamily: Path.getFilename(Assets.fonts.philosopher),
              color: const Color.fromRGBO(110, 53, 76, 1),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromRGBO(110, 53, 76, 1),
          actionTextColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color.fromRGBO(130, 147, 153, 1),
          ),
          contentPadding: EdgeInsets.zero,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(130, 147, 153, 1),
            ),
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(130, 147, 153, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ),
      );
}
