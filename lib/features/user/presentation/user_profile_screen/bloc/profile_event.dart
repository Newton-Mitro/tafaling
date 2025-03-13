part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class FetchProfileEvent extends ProfileEvent {
  final int fetchPage;
  final int userId;

  const FetchProfileEvent({required this.fetchPage, required this.userId});

  @override
  List<Object> get props => [fetchPage];
}
