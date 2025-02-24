import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/core/utils/app_shared_pref.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<LoadThemeEvent>(_loadTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }

  // This method handles the loading of the theme
  Future<void> _loadTheme(
      LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final theme = await AppSharedPref.getAppTheme();
    emit(theme == 'light' ? LightThemeState() : DarkThemeState());
  }

  // This method handles theme toggling
  Future<void> _toggleTheme(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final newState = state is LightThemeState
        ? const DarkThemeState()
        : const LightThemeState();
    emit(newState);
    await AppSharedPref.setAppTheme(
        newState is LightThemeState ? 'light' : 'dark');
  }
}
