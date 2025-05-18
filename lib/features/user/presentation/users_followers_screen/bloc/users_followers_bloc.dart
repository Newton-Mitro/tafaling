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

  UserFollowersBloc({required this.getFollowersUseCase})
    : super(UserFollowersInitial()) {
    on<FetchUserFollowers>(_onFetchUserFollowers);
  }

  // Event handler for fetching followers
  Future<void> _onFetchUserFollowers(
    FetchUserFollowers event,
    Emitter<UserFollowersState> emit,
  ) async {
    if (event.page == 1) {
      emit(UserFollowersLoading());
    } else {
      emit(UserFollowersLoadingMore());
    }

    try {
      final startRecord = (event.page - 1) * pageSize;
      final getFollowersParams = GetFollowersParams(
        targetUserId: event.userId,
        startRecord: startRecord,
        pageSize: pageSize,
      );
      final dataState = await getFollowersUseCase.call(getFollowersParams);

      dataState.fold(
        (failure) {
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
          if (followers.isEmpty) {
            hasMoreFollowers = false;
          }
          if (event.page == 1) {
            emit(UserFollowersLoaded(followers: followers));
          }
        },
      );
    } catch (e) {
      if (state is UserFollowersLoaded) {
        emit(
          UserFollowersErrorWithMore(
            message: e.toString(),
            followers: (state as UserFollowersLoaded).followers,
          ),
        );
      } else {
        emit(UserFollowersError(message: e.toString()));
      }
    }
  }
}
