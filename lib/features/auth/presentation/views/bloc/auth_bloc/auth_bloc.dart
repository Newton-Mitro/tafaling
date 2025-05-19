import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/registration_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegistrationUseCase registrationUseCase;
  final LogoutUseCase logoutUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registrationUseCase,
    required this.getAuthUserUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final loginParams = LoginParams(
      email: event.username,
      password: event.password,
    );
    final dataState = await loginUseCase.call(loginParams);

    dataState.fold(
      (failure) {
        if (failure is ValidationFailure) {
          emit(AuthValidationErrorState(failure.errors));
        } else {
          emit(AuthError(failure.message));
        }
      },
      (authUser) {
        emit(Authenticated(authUser));
      },
    );
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final registrationParams = RegistrationParams(
      name: event.name,
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );
    final dataState = await registrationUseCase.call(registrationParams);

    dataState.fold(
      (failure) {
        if (failure is ValidationFailure) {
          emit(AuthValidationErrorState(failure.errors));
        } else {
          emit(AuthError(failure.message));
        }
      },
      (authUser) {
        emit(Authenticated(authUser));
      },
    );
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await logoutUseCase.call(NoParams());
    emit(AuthInitial());
  }
}
