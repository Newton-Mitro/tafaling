part of 'users_followers_bloc.dart';

sealed class UsersFollowersState extends Equatable {
  const UsersFollowersState();
  
  @override
  List<Object> get props => [];
}

final class UsersFollowersInitial extends UsersFollowersState {}
