part of 'search_screen_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchUserModel> users;

  SearchLoaded(this.users);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
