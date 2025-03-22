part of 'app_state_bloc.dart';

sealed class AppStateEvent extends Equatable {
  const AppStateEvent();

  @override
  List<Object> get props => [];
}

final class IsAuthenticated extends AppStateEvent {
  const IsAuthenticated();
}

final class LogoutEvent extends AppStateEvent {
  const LogoutEvent();
}
