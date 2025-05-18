import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/usecases/registration_usecase.dart';

part 'registration_screen_event.dart';
part 'registration_screen_state.dart';

class RegistrationScreenBloc
    extends Bloc<RegistrationScreenEvent, RegistrationState> {
  final RegistrationUseCase registrationUseCase;

  RegistrationScreenBloc({required this.registrationUseCase})
    : super(RegistrationInitialState()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegistrationLoadingState());
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
            emit(RegistrationValidationErrorState(failure.errors));
          } else {
            emit(RegistrationErrorState(failure.message));
          }
        },
        (authUser) {
          emit(RegistrationSuccessState(authUser));
        },
      );
    });
  }
}
