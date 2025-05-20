import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchState> {
  final SearchUsersUseCase searchUsersUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMore = true;
  bool _isLoading = false;
  String _lastSearchText = '';

  SearchScreenBloc({required this.searchUsersUseCase})
    : super(SearchInitial()) {
    on<SearchUsersEvent>(_onSearchUsersEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  Future<void> _onSearchUsersEvent(
    SearchUsersEvent event,
    Emitter<SearchState> emit,
  ) async {
    // Prevent multiple loads
    if (_isLoading || !_hasMore) return;

    // Reset page if new search
    if (event.isInitialLoad || _lastSearchText != event.searchText) {
      _currentPage = 1;
      _hasMore = true;
    }

    _isLoading = true;
    _lastSearchText = event.searchText;

    final List<UserEntity> currentUsers =
        state is SearchLoaded ? List.from((state as SearchLoaded).users) : [];

    if (_currentPage == 1) {
      emit(SearchLoading());
    }

    final searchUsersParams = SearchUsersParams(
      searchText: event.searchText,
      userId: event.userId,
      startRecord: (_currentPage - 1) * _pageSize,
      pageSize: _pageSize,
    );

    final dataState = await searchUsersUseCase(searchUsersParams);

    dataState.fold(
      (failure) {
        _isLoading = false;
        emit(SearchError(failure.message));
      },
      (data) {
        _isLoading = false;
        if (data.length < _pageSize) {
          _hasMore = false;
        } else {
          _currentPage++;
        }

        final updatedUsers = currentUsers..addAll(data);
        emit(SearchLoaded(updatedUsers));
      },
    );
  }

  void _onResetSearchEvent(ResetSearchEvent event, Emitter<SearchState> emit) {
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    _lastSearchText = '';
    emit(SearchInitial());
  }
}
