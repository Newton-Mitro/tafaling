import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/utils/shared_prefs.dart';
import 'package:tafaling/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

part 'signup_screen_event.dart';
part 'signup_screen_state.dart';

class SignUpScreenBloc extends Bloc<SignUpScreenEvent, SignUpScreenState> {
  final RegisterUseCase registerUseCase;

  SignUpScreenBloc(this.registerUseCase) : super(SignUpInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
  }

  Future<void> _onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<SignUpScreenState> emit) async {
    final accessToken = await SharedPrefs.getAccessToken();
    final refreshToken = await SharedPrefs.getRefreshToken();
    final user = await SharedPrefs.getUser();
    if (accessToken != null) {
      emit(LoggedIn(
          accessToken: accessToken,
          refreshToken: refreshToken!,
          user: jsonDecode(user!)));
    } else {
      emit(SignUpInitial());
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<SignUpScreenState> emit) async {
    emit(SignUpLoading());
    final validationErrors = _validateRegistration(event);
    if (validationErrors.isNotEmpty) {
      emit(SignUpValidationError(validationErrors));
      return;
    }
    try {
      final res = await registerUseCase(
          event.name, event.email, event.password, event.confirmPassword);
      emit(RegisteredCompleted());
    } catch (e) {
      if (e is ValidationException) {
        emit(SignUpValidationError(e.errors));
      } else {
        emit(SignUpError(e.toString()));
      }
    }
  }

  Map<String, dynamic> _validateRegistration(RegisterEvent event) {
    final errors = <String, dynamic>{};

    if (event.name.isEmpty) {
      errors['name'] = ['Name cannot be empty'];
    }
    if (event.email.isEmpty) {
      errors['email'] = ['Email cannot be empty'];
    }
    if (event.password.isEmpty) {
      errors['password'] = ['Password cannot be empty'];
    }
    if (event.confirmPassword.isEmpty) {
      errors['confirm_password'] = ['Confirm Password cannot be empty'];
    } else if (event.password != event.confirmPassword) {
      errors['confirm_password'] = ['Passwords do not match'];
    }

    return errors;
  }
}
