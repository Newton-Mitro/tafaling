import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state_event.dart';
part 'app_state_state.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppStateState> {
  AppStateBloc() : super(AppStateInitial()) {
    on<IsAuthenticated>(_onIsAuthenticatedEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onIsAuthenticatedEvent(
    IsAuthenticated event,
    Emitter<AppStateState> emit,
  ) async {
    emit(AppStateInitial());
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AppStateState> emit,
  ) async {
    emit(Unauthenticated());
  }
}
