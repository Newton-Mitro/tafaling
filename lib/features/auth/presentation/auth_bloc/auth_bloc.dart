import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
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
      try {
        final loginParams = LoginParams(
          email: event.username,
          password: event.password,
        );
        final responseState = await loginUseCase.call(
          params: loginParams,
        );
        if (responseState is ResponseSuccess && responseState.data != null) {
          emit(Authenticated(responseState.data!));
        }

        if (responseState is ResponseFailed && responseState.error != null) {
          emit(AuthError("Login failed: Invalid credentials"));
        }
      } catch (e) {
        if (e is ValidationException) {
          emit(AuthValidationError(e.errors));
        } else {
          emit(AuthError("Login failed: Invalid credentials"));
        }
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final registrationParams = RegistrationParams(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        final responseState = await registrationUseCase.call(
          params: registrationParams,
        );
        if (responseState is ResponseSuccess && responseState.data != null) {
          emit(Authenticated(responseState.data!));
        }

        if (responseState is ResponseFailed && responseState.error != null) {
          emit(AuthError("Registration failed"));
        }
      } catch (e) {
        if (e is ValidationException) {
          emit(AuthValidationError(e.errors));
        } else {
          emit(AuthError("Registration failed"));
        }
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase.call();
      emit(
        Unauthenticated(),
      );
    });

    on<CheckAuthEvent>((event, emit) async {
      final responseState = await isLoggedInUseCase.call();

      if (responseState is ResponseSuccess && responseState.data == true) {
        final userResponseState = await authUserUsecase.call();
        if (userResponseState is ResponseSuccess &&
            userResponseState.data != null) {
          emit(Authenticated(userResponseState.data!));
        }
        if (userResponseState is ResponseFailed &&
            userResponseState.error != null) {
          emit(Unauthenticated());
        }
      }

      if (responseState is ResponseFailed && responseState.error != null) {
        emit(Unauthenticated());
      }
    });
  }
}
