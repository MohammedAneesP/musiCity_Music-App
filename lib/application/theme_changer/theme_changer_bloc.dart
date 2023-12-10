import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musi_city/functions/themechange/themechanging.dart';

part 'theme_changer_event.dart';
part 'theme_changer_state.dart';



class ThemeChangerBloc extends Bloc<ThemeChangerEvent, ThemeChangerState> {
  ThemeChangerBloc() : super(ThemeChangerInitial()) {
    on<IsDarkMode>((event, emit) {
      final anTheme = MyThemes.lightTheme;
      return emit(ThemeChangerState(errorMessage: "", anTheme: anTheme));
    });
    on<IsLightMode>((event, emit) {
      final anTheme = MyThemes.darkTheme;
      return emit(ThemeChangerState(errorMessage: "", anTheme: anTheme));
    });
  }
}
