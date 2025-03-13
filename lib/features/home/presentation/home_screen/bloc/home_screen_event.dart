part of 'home_screen_bloc.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class InitializeHomeScreenEvent extends HomeScreenEvent {}

final class TabChangeEvent extends HomeScreenEvent {
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});
}

class SetGuestStateEvent extends HomeScreenEvent {
  const SetGuestStateEvent();
}
