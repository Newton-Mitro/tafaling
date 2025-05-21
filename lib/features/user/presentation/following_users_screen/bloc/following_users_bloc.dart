import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/get_following_users_usecase.dart';

part 'following_users_event.dart';
part 'following_users_state.dart';

class FollowingUsersBloc
    extends Bloc<FollowingUsersEvent, FollowingUsersState> {
  final GetFollowingUsersUseCase getFollowingUsersUseCase;

  bool hasMoreFollowers = true;
  int currentPage = 1;
  final int pageSize = 10;
  bool _isLoading = false;

  final List<UserEntity> _followers = [];

  FollowingUsersBloc({required this.getFollowingUsersUseCase})
    : super(FollowingUsersInitial()) {
    on<FetchFollowingUsers>(_onFetchFollowingUsers);
  }

  Future<void> _onFetchFollowingUsers(
    FetchFollowingUsers event,
    Emitter<FollowingUsersState> emit,
  ) async {
    if (_isLoading || !hasMoreFollowers) return;

    _isLoading = true;

    final isInitialLoad = event.page == 1;

    if (isInitialLoad) {
      _followers.clear();
      emit(FollowingUsersLoading());
    } else {
      emit(FollowingUsersLoadingMore(followers: List.of(_followers)));
    }

    final startRecord = (event.page - 1) * pageSize;

    final result = await getFollowingUsersUseCase(
      GetFollowingUsersParams(
        targetUserId: event.userId,
        startRecord: startRecord,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) {
        _isLoading = false;
        if (!isInitialLoad) {
          emit(
            FollowingUsersErrorWithMore(
              message: failure.message,
              followers: List.of(_followers),
            ),
          );
        } else {
          emit(FollowingUsersError(message: failure.message));
        }
      },
      (fetchedFollowers) {
        _isLoading = false;

        if (fetchedFollowers.length < pageSize) {
          hasMoreFollowers = false;
        }

        _followers.addAll(fetchedFollowers);
        currentPage = event.page + 1;

        emit(FollowingUsersLoaded(followers: List.of(_followers)));
      },
    );
  }
}
