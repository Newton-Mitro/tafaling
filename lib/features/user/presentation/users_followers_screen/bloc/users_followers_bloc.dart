import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/resources/response_state.dart';
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
      final dataState = await getFollowersUseCase.call(
        params: getFollowersParams,
      );

      if (dataState is SuccessData) {
        hasMoreFollowers = dataState.data!.length >= pageSize;
        currentPage = event.page;

        if (event.page == 1) {
          emit(UserFollowersLoaded(followers: dataState.data!));
        } else {
          final List<UserEntity> currentFollowers =
              (state is UserFollowersLoaded)
                  ? (state as UserFollowersLoaded).followers
                  : [];
          emit(
            UserFollowersLoadedWithMore(
              followers: currentFollowers + dataState.data!,
              hasMore: hasMoreFollowers,
            ),
          );
        }
      } else if (dataState is FailedData) {
        throw Exception(dataState.error!.message);
      }
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
