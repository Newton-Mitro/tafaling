part of 'home_screen_bloc.dart';

class HomeScreenState extends Equatable {
  final int authUserId;
  final int guestStateId;
  final int tabIndex;

  const HomeScreenState({
    required this.authUserId,
    required this.guestStateId,
    required this.tabIndex,
  });

  HomeScreenState copyWith({
    int? authUserId,
    int? tabIndex,
    int? guestStateId,
  }) {
    return HomeScreenState(
      authUserId: authUserId ?? this.authUserId,
      tabIndex: tabIndex ?? this.tabIndex,
      guestStateId: guestStateId ?? this.guestStateId,
    );
  }

  @override
  List<Object> get props => [
        authUserId,
        tabIndex,
        guestStateId,
      ];
}

class GuestState extends HomeScreenState {
  const GuestState({
    required super.authUserId,
    required super.guestStateId,
    required super.tabIndex,
  });
}
