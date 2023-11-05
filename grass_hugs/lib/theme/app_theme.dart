import 'package:flutter/material.dart';
import 'package:grass_hugs/helper/colors_sys.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    primaryColor: ColorSys.kprimary,
    scaffoldBackgroundColor: ColorSys.ksecondary,
    fontFamily: 'Rubik',
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ColorSys.kwhite,
        fontSize: 24,
        fontFamily: "Rubik",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: ColorSys.kwhite,
        fontSize: 16,
        fontFamily: "Rubik",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: ColorSys.kwhite,
        fontSize: 16,
        fontFamily: "Rubik",
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
