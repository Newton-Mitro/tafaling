part of 'my_profile_bloc.dart';

sealed class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends MyProfileEvent {
  const LoadUserProfileEvent();
}

class FollowUserEvent extends MyProfileEvent {
  final int userId;
  const FollowUserEvent(this.userId);
}

class UnfollowUserEvent extends MyProfileEvent {
  final int userId;
  const UnfollowUserEvent(this.userId);
}
