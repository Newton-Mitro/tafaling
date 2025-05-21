part of 'my_profile_bloc.dart';

sealed class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends MyProfileState {}

final class ProfileLoading extends MyProfileState {}

final class ProfileLoaded extends MyProfileState {
  final UserEntity user;
  const ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}
