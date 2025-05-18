import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginUseCase loginUseCase;

  LoginScreenBloc({required this.loginUseCase}) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      final loginParams = LoginParams(
        email: event.username,
        password: event.password,
      );
      final dataState = await loginUseCase.call(loginParams);

      dataState.fold(
        (failure) {
          if (failure is ValidationFailure) {
            emit(LoginValidationErrorState(failure.errors));
          } else {
            emit(LoginErrorState(failure.message));
          }
        },
        (authUser) {
          emit(LoginSuccessState(authUser));
        },
      );
    });
  }
}
