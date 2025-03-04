import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(language: 'en')) {
    on<LanguageEvent>(_changeLanguage);
    on<LoadLocaleEvent>(_loadLocale);
  }

  Future<void> _loadLocale(
      LoadLocaleEvent event, Emitter<LanguageState> emit) async {
    final locale = await AppSharedPref.getAppLocale();
    emit(LanguageState(language: locale));
  }

  // Method to handle language change event
  void _changeLanguage(LanguageEvent event, Emitter<LanguageState> emit) async {
    if (event is LanguageSelected) {
      await AppSharedPref.setAppLocale(event.language);
      emit(state.copyWith(language: event.language));
    }
  }
}
