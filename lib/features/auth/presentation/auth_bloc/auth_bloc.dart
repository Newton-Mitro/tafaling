import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/usecases/auth_user_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/registration_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegistrationUseCase registrationUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUsecase logoutUseCase;
  final IsLoggedInUsecase isLoggedInUseCase;
  final AuthUserUsecase authUserUsecase;

  AuthBloc({
    required this.registrationUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.isLoggedInUseCase,
    required this.authUserUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final loginParams = LoginParams(
        email: event.username,
        password: event.password,
      );
      final dataState = await loginUseCase.call(
        params: loginParams,
      );
      if (dataState is SuccessData && dataState.data != null) {
        emit(Authenticated(dataState.data!));
      }

      if (dataState is FailedData && dataState.error != null) {
        emit(AuthError("Login failed: Invalid credentials"));
      }

      if (dataState is ValidationFailedData &&
          dataState.errors!.errors.isNotEmpty) {
        emit(AuthValidationError(dataState.errors!.errors));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final registrationParams = RegistrationParams(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      final dataState = await registrationUseCase.call(
        params: registrationParams,
      );
      if (dataState is SuccessData && dataState.data != null) {
        emit(Authenticated(dataState.data!));
      }

      if (dataState is FailedData && dataState.error != null) {
        emit(AuthError("Registration failed"));
      }

      if (dataState is ValidationFailedData &&
          dataState.errors!.errors.isNotEmpty) {
        emit(AuthValidationError(dataState.errors!.errors));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase.call();
      emit(
        Unauthenticated(),
      );
    });

    on<CheckAuthEvent>((event, emit) async {
      final dataState = await isLoggedInUseCase.call();

      if (dataState is SuccessData && dataState.data == true) {
        final userdataState = await authUserUsecase.call();
        if (userdataState is SuccessData && userdataState.data != null) {
          emit(Authenticated(userdataState.data!));
        }
        if (userdataState is FailedData && userdataState.error != null) {
          emit(Unauthenticated());
        }
      }

      if (dataState is FailedData && dataState.error != null) {
        emit(Unauthenticated());
      }
    });
  }
}
