part of 'following_users_bloc.dart';

sealed class FollowingUsersState extends Equatable {
  const FollowingUsersState();
  
  @override
  List<Object> get props => [];
}

final class FollowingUsersInitial extends FollowingUsersState {}
