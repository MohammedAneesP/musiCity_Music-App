import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode =>  themeMode == ThemeMode.light;

  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyThemes {
  static final dakTheme = ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[850],
    colorScheme: const ColorScheme.dark(),
    primaryColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white)
  );

  static final lightTheme = ThemeData(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black)
  );
}