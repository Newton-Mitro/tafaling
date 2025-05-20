part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent();

  @override
  List<Object?> get props => [];
}

class SearchUsersEvent extends SearchScreenEvent {
  final String searchText;
  final int userId;
  final bool isInitialLoad;

  const SearchUsersEvent({
    required this.searchText,
    required this.userId,
    this.isInitialLoad = false,
  });

  @override
  List<Object> get props => [searchText, userId, isInitialLoad];
}

class ResetSearchEvent extends SearchScreenEvent {
  const ResetSearchEvent();

  @override
  List<Object?> get props => [];
}
