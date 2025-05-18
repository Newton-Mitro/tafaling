import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUsecase logoutUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  AuthBloc({required this.logoutUseCase, required this.getAuthUserUseCase})
    : super(AuthInitial()) {
    on<IsAuthenticatedEvent>((event, emit) async {
      emit(AuthLoading());
      final authUserState = await getAuthUserUseCase.call(GetAuthUserParams());
      authUserState.fold(
        (failure) => emit(AuthError(failure.message)),
        (authUser) => emit(Authenticated(authUser)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await logoutUseCase.call(NoParams());
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (response) => emit(Unauthenticated()),
      );
    });
  }
}
