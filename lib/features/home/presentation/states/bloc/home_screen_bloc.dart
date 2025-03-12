import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/shared_prefs.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc()
      : super(const HomeScreenState(
          authUserId: 0,
          tabIndex: 0,
          guestStateId: 0,
        )) {
    _onLoadState();
    on<TabChangeEvent>(_onTabChange);
    on<InitializeHomeScreenEvent>(_onInitializeHomeScreen);
    on<SetGuestStateEvent>((_, emit) => _setGuestState(emit));
  }

  Future<Map<String, dynamic>> _getUserCredentials() async {
    final userId = await SharedPrefs.getUserId();
    final accessToken = await SharedPrefs.getAccessToken();
    return {'userId': userId, 'accessToken': accessToken};
  }

  _onLoadState() async {
    final credentials = await _getUserCredentials();
    final userId = credentials['userId'];
    final accessToken = credentials['accessToken'];
    emit(state.copyWith(authUserId: userId));
  }

  void _setGuestState(Emitter<HomeScreenState> emit) {
    emit(GuestState(
      authUserId: 0,
      guestStateId: Random().nextInt(100) + 50,
      tabIndex: 0,
    ));
  }

  void _onTabChange(TabChangeEvent event, Emitter<HomeScreenState> emit) async {
    final accessToken = await SharedPrefs.getAccessToken();

    if (event.tabIndex != 0 && accessToken == null) {
      _setGuestState(emit);
    } else {
      emit(state.copyWith(tabIndex: event.tabIndex));
    }
  }

  void _onInitializeHomeScreen(
      InitializeHomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(tabIndex: 0, authUserId: 0, guestStateId: 0));
  }
}
