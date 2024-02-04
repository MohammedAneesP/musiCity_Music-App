import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[850]),
      scaffoldBackgroundColor: Colors.grey[850],
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.white),
          actionsIconTheme:const IconThemeData(color: Colors.white),
          iconTheme:const IconThemeData(color: Colors.white)),
      colorScheme: const ColorScheme.dark(),
      primaryColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white));

  static final lightTheme = ThemeData(
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.white),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black)),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black));
}
