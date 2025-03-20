part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent {}

class SearchUsersEvent extends SearchScreenEvent {
  final String searchText;

  SearchUsersEvent(this.searchText);
}

class ResetSearchEvent extends SearchScreenEvent {}
