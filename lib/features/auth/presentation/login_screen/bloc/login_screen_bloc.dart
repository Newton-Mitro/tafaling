import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginUseCase loginUseCase;

  LoginScreenBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
  }

  Future<void> _onLoginEvent(
      LoginEvent event, Emitter<LoginScreenState> emit) async {
    emit(LoginLoading());
    try {
      final loginParams =
          LoginParams(email: event.username, password: event.password);
      final loggedInUser = await loginUseCase(params: loginParams);
      emit(LoggedIn(
          accessToken: loggedInUser.accessToken,
          refreshToken: loggedInUser.refreshToken,
          user: loggedInUser.user as UserModel));
    } catch (e) {
      if (e is ValidationException) {
        emit(LoginValidationError(e.errors));
      } else {
        emit(LoginError(e.toString()));
      }
    }
  }

  Future<void> _onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<LoginScreenState> emit) async {
    final accessToken = await AppSharedPref.getAccessToken();
    final refreshToken = await AppSharedPref.getRefreshToken();
    final user = await AppSharedPref.getAuthUser();
    if (accessToken != null) {
      emit(LoggedIn(
          accessToken: accessToken,
          refreshToken: refreshToken!,
          user: user as UserModel));
    } else {
      emit(LoginInitial());
    }
  }
}
