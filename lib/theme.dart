import 'package:flutter/material.dart';

class SpaceStationTycoonTheme {
  static ThemeData _baseThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[500],
    accentColor: Colors.yellow[500],
    fontFamily: 'Roboto'
  );

  static ThemeData darkThemeData = _baseThemeData;

  // static ThemeData baseThemeData = ThemeData.from(
  //   colorScheme: ColorScheme(
  //     primary: Colors.blueGrey.shade500,
  //     primaryVariant: Colors.blueGrey.shade900,
  //     onPrimary: Colors.white,

  //     secondary: Colors.yellow.shade500,
  //     secondaryVariant: Colors.yellow.shade900,
  //     onSecondary: Colors.black,

  //     surface: Colors.blueGrey.shade100,
  //     onSurface: Colors.black,

  //     background: Colors.blueGrey.shade50,
  //     onBackground: Colors.black,

  //     error: Colors.deepOrange.shade600,
  //     onError: Colors.white,

  //     brightness: Brightness.dark,
  //   ),
  //   textTheme: Typography.tall2018.merge(
  //     Typography.whiteMountainView.copyWith(
        
  //     )
  //   )
  // );
}