import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_skeleton/utils/app_shared_pref.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(language: 'en')) {
    _loadLocale();
    on<LanguageEvent>(_changeLanguage);
  }

  Future<void> _loadLocale() async {
    final locale = await AppSharedPref.getAppLocale();
    emit(LanguageState(language: locale));
  }

  void _changeLanguage(LanguageEvent event, Emitter<LanguageState> emit) async {
    if (event is LanguageSelected) {
      await AppSharedPref.setAppLocale(event.language);
      emit(state.copyWith(language: event.language));
    }
  }
}
