import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeData defaultThemeData = ThemeData(
    primarySwatch: Colors.yellow,
    accentColor: Colors.green,
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    secondaryHeaderColor: Colors.cyan,
    // accentColor: Colors.green,
    // Define the default font family.
    fontFamily: 'Monotype Coursiva',
    // Define the TextTheme that specifies the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
        headline5: TextStyle(
            fontSize: 32.0, fontStyle: FontStyle.italic, fontFamily: 'Hind')),
    backgroundColor: Colors.orange,
  );
  static _ExendedStyles extStyle = _ExendedStyles();
}

class _ExendedStyles{
  Color btnFltForegroundColor = Colors.red;
  ButtonStyle btnStyle = ButtonStyle();
}
