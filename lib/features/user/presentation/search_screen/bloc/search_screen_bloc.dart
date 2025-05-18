import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/utils/local_storage.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

const int postsPerPage = 5;

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchState> {
  final SearchUsersUseCase searchUsersUseCase;
  final LocalStorage localStorage;

  int _fetchPage = 1;
  bool _hasMore = true;

  SearchScreenBloc({
    required this.searchUsersUseCase,
    required this.localStorage,
  }) : super(SearchInitial()) {
    on<SearchUsersEvent>(_onSearchUsersEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  Future<void> _onSearchUsersEvent(
    SearchUsersEvent event,
    Emitter<SearchState> emit,
  ) async {
    final List<UserEntity> currentUsers =
        state is SearchLoaded
            ? List<UserEntity>.from((state as SearchLoaded).users)
            : [];

    emit(SearchLoading());

    final authUser = await localStorage.getString(Constants.authUserKey);
    final user = UserModel.fromJson(jsonDecode(authUser ?? ''));

    final searchUsersParams = SearchUsersParams(
      searchText: event.searchText,
      userId: user.id,
      startRecord: 0,
      pageSize: 50,
    );

    final dataState = await searchUsersUseCase(searchUsersParams);

    dataState.fold((failure) => emit(SearchError(failure.message)), (data) {
      if (data.isEmpty) {
        emit(SearchLoaded(currentUsers));
      } else {
        currentUsers.addAll(data);
        emit(SearchLoaded(currentUsers));
      }
    });
  }

  void _onResetSearchEvent(ResetSearchEvent event, Emitter<SearchState> emit) {
    _fetchPage = 1;
    _hasMore = true;
    emit(SearchInitial());
  }
}
