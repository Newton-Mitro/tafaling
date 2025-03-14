import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/user/data/models/search_user_model.dart';
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
  bool _hasMore = true; // Indicates if there are more pages to fetch

  SearchScreenBloc(
    this.searchUsersUseCase,
    this.followUserUseCase,
    this.unFollowUserUseCase,
  ) : super(SearchInitial()) {
    on<SearchUsersEvent>(_onSearchUsersEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<UnFollowUserEvent>(_onUnFollowUserEvent);
  }

  /// Fetch user credentials (userId and accessToken)
  Future<Map<String, dynamic>> _getUserCredentials() async {
    var user = await AppSharedPref.getAuthUser();
    var accessToken = await AppSharedPref.getAccessToken();
    return {'userId': user?.id, 'accessToken': accessToken};
  }

  Future<void> _onFollowUserEvent(
      FollowUserEvent event, Emitter<SearchState> emit) async {
    final res = await followUserUseCase(event.followingUserId);

    final updatedUsers = _updateSearchUsers(event.followingUserId);
    emit(SearchLoaded(updatedUsers));
  }

  Future<void> _onUnFollowUserEvent(
      UnFollowUserEvent event, Emitter<SearchState> emit) async {
    final res = await unFollowUserUseCase(event.followingUserId);
    final updatedUsers = _updateSearchUsers(event.followingUserId);
    emit(SearchLoaded(updatedUsers));
    // update search user model
  }

  List<SearchUserModel> _updateSearchUsers(int postId) {
    final postIndex = (state as SearchLoaded)
        .users
        .indexWhere((user) => user.userId == postId);
    if (postIndex == -1) return (state as SearchLoaded).users;

    final isFollowing = !(state as SearchLoaded).users[postIndex].isFollowing;
    final updatedPost = (state as SearchLoaded).users[postIndex].copyWith(
          isFollowing: isFollowing,
        );

    final updatedPosts =
        List<SearchUserModel>.from((state as SearchLoaded).users)
          ..[postIndex] = updatedPost;

    return updatedPosts;
  }

  /// Handle the [SearchUsersEvent] to fetch and load user data
  Future<void> _onSearchUsersEvent(
      SearchUsersEvent event, Emitter<SearchState> emit) async {
    final List<SearchUserModel> currentUsers = state is SearchLoaded
        ? List<SearchUserModel>.from((state as SearchLoaded).users)
        : [];

    emit(SearchLoading()); // Emit loading state for more users

    try {
      final credentials = await _getUserCredentials();
      final userId = credentials['userId'];

      // Fetch new users from the use case
      final newUsers = await searchUsersUseCase(
        userId,
        event.searchText,
        0,
        50,
      );

      emit(SearchLoaded(newUsers)); // Emit the loaded state with users
    } catch (e) {
      emit(SearchError('Failed to load users'));
    }
  }

  /// Handle the [ResetSearchEvent] to reset the search state
  void _onResetSearchEvent(ResetSearchEvent event, Emitter<SearchState> emit) {
    _fetchPage = 1;
    _hasMore = true;
    emit(SearchInitial());
  }
}
