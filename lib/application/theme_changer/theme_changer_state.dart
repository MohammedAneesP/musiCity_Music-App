part of 'theme_changer_bloc.dart';

class ThemeChangerState {
  final ThemeData anTheme;
  final String errorMessage;
  ThemeChangerState({required this.errorMessage, required this.anTheme});
}

class ThemeChangerInitial extends ThemeChangerState {
  ThemeChangerInitial() : super(errorMessage: '', anTheme: MyThemes.darkTheme);
}
