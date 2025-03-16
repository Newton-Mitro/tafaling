import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.isLoggedInUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final loginParams =
            LoginParams(email: event.username, password: event.password);
        final user = await loginUseCase.call(params: loginParams);
        emit(Authenticated(user));
      } on Map<String, dynamic> catch (errors) {
        emit(AuthValidationError(errors));
      } catch (e) {
        emit(AuthError("Login failed: Invalid credentials"));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final authUser = await registerUseCase.call(
            event.name, event.email, event.password, event.confirmPassword);
        emit(Authenticated(authUser));
      } on Map<String, dynamic> catch (errors) {
        emit(AuthValidationError(errors));
      } catch (e) {
        emit(AuthError("Registration failed"));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase.call();
      emit(Unauthenticated());
    });

    on<CheckAuthEvent>((event, emit) async {
      final isLoggedIn = await isLoggedInUseCase.call();
      if (isLoggedIn) {
        emit(Authenticated(AuthUserModel(
            accessToken: accessToken,
            refreshToken: refreshToken,
            user: user as UserModel)));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
