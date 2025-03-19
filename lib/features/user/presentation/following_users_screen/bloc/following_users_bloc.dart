import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/get_following_users_usecase.dart';

part 'following_users_event.dart';
part 'following_users_state.dart';

class FollowingUsersBloc
    extends Bloc<FollowingUsersEvent, FollowingUsersState> {
  final GetFollowingUsersUseCase getFollowingUsersUseCase;

  bool hasMoreFollowers = true;
  int currentPage = 1;
  int pageSize = 10;

  FollowingUsersBloc({required this.getFollowingUsersUseCase})
    : super(FollowingUsersInitial()) {
    on<FetchFollowingUsers>(_onFetchFollowingUsers);
  }

  // Event handler for fetching followers
  Future<void> _onFetchFollowingUsers(
    FetchFollowingUsers event,
    Emitter<FollowingUsersState> emit,
  ) async {
    if (event.page == 1) {
      emit(FollowingUsersLoading());
    } else {
      emit(FollowingUsersLoadingMore());
    }

    try {
      final startRecord = (event.page - 1) * pageSize;
      final getFollowingUsersParams = GetFollowingUsersParams(
        targetUserId: event.userId,
        startRecord: startRecord,
        pageSize: pageSize,
      );
      final dataState = await getFollowingUsersUseCase.call(
        params: getFollowingUsersParams,
      );

      if (dataState is SuccessData) {
        hasMoreFollowers = dataState.data!.length >= pageSize;
        currentPage = event.page;

        if (event.page == 1) {
          emit(FollowingUsersLoaded(followers: dataState.data!));
        } else {
          final List<UserEntity> currentFollowers =
              (state is FollowingUsersLoaded)
                  ? (state as FollowingUsersLoaded).followers
                  : [];
          emit(
            FollowingUsersLoadedWithMore(
              followers: currentFollowers + dataState.data!,
              hasMore: hasMoreFollowers,
            ),
          );
        }
      } else if (dataState is FailedData) {
        throw Exception(dataState.error!.message);
      }
    } catch (e) {
      if (state is FollowingUsersLoaded) {
        emit(
          FollowingUsersErrorWithMore(
            message: e.toString(),
            followers: (state as FollowingUsersLoaded).followers,
          ),
        );
      } else {
        emit(FollowingUsersError(message: e.toString()));
      }
    }
  }
}
