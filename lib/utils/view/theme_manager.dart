import 'package:flutter/material.dart';

class ThemeManager {
  static String appName = "Ventas Clothing";

  //Colors for theme
  static Color backgroundWhite = Colors.white;
  static Color backgroundBlack = Colors.black;
  static Color secondaryColor = Color(0xFF6ab8f7);
  static Color mainColor = Colors.blue;

  static int defaultPadding = 20;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: backgroundWhite,
    primaryColor: mainColor,
    accentColor: secondaryColor,
    scaffoldBackgroundColor: backgroundWhite,
    appBarTheme: AppBarTheme(
      elevation: 0,
      toolbarHeight: 0,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w800),
      headline2: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
      headline3: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
      headline4: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
      button: TextStyle(
          color: secondaryColor, fontSize: 18.0, fontWeight: FontWeight.w500),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.teal,
      height: 50.0,
      textTheme: ButtonTextTheme.primary,
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.teal),
  );
}
