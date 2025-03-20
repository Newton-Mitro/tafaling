import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

const int postsPerPage = 10;

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchState> {
  final SearchUsersUseCase searchUsersUseCase;
  final FollowUserUseCase followUserUseCase;
  final UnFollowUserUseCase unFollowUserUseCase;

  int _fetchPage = 1;
  bool _hasMore = true;

  SearchScreenBloc(
    this.searchUsersUseCase,
    this.followUserUseCase,
    this.unFollowUserUseCase,
  ) : super(SearchInitial()) {
    on<SearchUsersEvent>(_onSearchUsersEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  Future<Map<String, dynamic>> _getUserCredentials() async {
    var user = await AppSharedPref.getAuthUser();
    var accessToken = await AppSharedPref.getAccessToken();
    return {'userId': user?.id, 'accessToken': accessToken};
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

    final credentials = await _getUserCredentials();
    final userId = credentials['userId'];

    final searchUsersParams = SearchUsersParams(
      searchText: event.searchText,
      userId: userId,
      startRecord: 0,
      pageSize: 50,
    );

    final dataState = await searchUsersUseCase(params: searchUsersParams);

    if (dataState is SuccessData && dataState.data != null) {
      emit(SearchLoaded(dataState.data!));
    }

    if (dataState is FailedData && dataState.error != null) {
      emit(SearchError(dataState.error!.message));
    }
  }

  void _onResetSearchEvent(ResetSearchEvent event, Emitter<SearchState> emit) {
    _fetchPage = 1;
    _hasMore = true;
    emit(SearchInitial());
  }
}
