import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[850],
      colorScheme: const ColorScheme.dark(),
      primaryColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black));
}
