import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/registration_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegistrationUseCase registrationUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUsecase logoutUseCase;

  AuthBloc({
    required this.registrationUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final loginParams = LoginParams(
        email: event.username,
        password: event.password,
      );
      final dataState = await loginUseCase.call(params: loginParams);
      if (dataState is SuccessData && dataState.data != null) {
        emit(Authenticated(dataState.data!));
      }

      if (dataState is FailedData && dataState.error != null) {
        switch (dataState.error) {
          case NetworkFailure():
            emit(AuthError(dataState.error!.message));
            break;
          case UnauthorizedFailure():
            emit(AuthError(dataState.error!.message));
            break;
          case ServerFailure():
            emit(AuthError(dataState.error!.message));
            break;
          case CacheFailure():
            emit(AuthError(dataState.error!.message));
            break;
          default:
            emit(AuthError(dataState.error!.message));
        }
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
        switch (dataState.error) {
          case NetworkFailure():
            emit(AuthError(dataState.error!.message));
            break;
          case UnauthorizedFailure():
            emit(AuthError(dataState.error!.message));
            break;
          case ServerFailure():
            emit(AuthError(dataState.error!.message));
            break;
          case CacheFailure():
            emit(AuthError(dataState.error!.message));
            break;
          default:
            emit(AuthError(dataState.error!.message));
        }
      }

      if (dataState is ValidationFailedData &&
          dataState.errors!.errors.isNotEmpty) {
        emit(AuthValidationError(dataState.errors!.errors));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      await logoutUseCase.call();
      emit(Unauthenticated());
    });
  }
}
