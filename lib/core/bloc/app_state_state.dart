part of 'app_state_bloc.dart';

sealed class AppStateState extends Equatable {
  const AppStateState();

  @override
  List<Object> get props => [];
}

final class AppStateInitial extends AppStateState {}

final class Unauthenticated extends AppStateState {}
