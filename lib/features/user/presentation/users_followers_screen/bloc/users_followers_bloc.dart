import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/get_followers_usecase.dart';

part 'users_followers_event.dart';
part 'users_followers_state.dart';

class UserFollowersBloc extends Bloc<UserFollowersEvent, UserFollowersState> {
  final GetFollowersUseCase getFollowersUseCase;

  bool hasMoreFollowers = true;
  int currentPage = 1;
  int pageSize = 100;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UserFollowersBloc({required this.getFollowersUseCase})
    : super(UserFollowersInitial()) {
    on<FetchUserFollowers>(_onFetchUserFollowers);
  }

  Future<void> _onFetchUserFollowers(
    FetchUserFollowers event,
    Emitter<UserFollowersState> emit,
  ) async {
    if (_isLoading || !hasMoreFollowers) return;

    _isLoading = true;

    if (event.page == 1) {
      emit(UserFollowersLoading());
    } else {
      emit(UserFollowersLoadingMore());
    }

    final startRecord = (event.page - 1) * pageSize;

    final params = GetFollowersParams(
      targetUserId: event.userId,
      startRecord: startRecord,
      pageSize: pageSize,
    );

    final result = await getFollowersUseCase(params);

    result.fold(
      (failure) {
        _isLoading = false;
        if (state is UserFollowersLoaded) {
          emit(
            UserFollowersErrorWithMore(
              message: failure.message,
              followers: (state as UserFollowersLoaded).followers,
            ),
          );
        } else {
          emit(UserFollowersError(message: failure.message));
        }
      },
      (followers) {
        _isLoading = false;

        final previous =
            state is UserFollowersLoaded
                ? (state as UserFollowersLoaded).followers
                : <UserEntity>[];

        if (followers.length < pageSize) {
          hasMoreFollowers = false;
        } else {
          currentPage = event.page + 1;
        }

        final allFollowers = [...previous, ...followers];
        emit(UserFollowersLoaded(followers: allFollowers));
      },
    );
  }
}
