import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeData defaultThemeData = ThemeData(
    accentColor: Colors.blue,
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    secondaryHeaderColor: Colors.green,
    // accentColor: Colors.green,
    // Define the default font family.
    fontFamily: 'Monotype Coursiva',
    // Define the TextTheme that specifies the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
        headline5: TextStyle(
            fontSize: 32.0, fontStyle: FontStyle.italic, fontFamily: 'Hind')),
    backgroundColor: Colors.green,
  );
  static _ExendedStyles extStyle = _ExendedStyles();
}

class _ExendedStyles{
  Color btnFltForegroundColor = Colors.red;
  ButtonStyle btnStyle = ButtonStyle();
}
