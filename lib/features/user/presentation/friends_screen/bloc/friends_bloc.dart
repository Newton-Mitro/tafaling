import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/user/user_module.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetSuggestedUsersUseCase getSuggestedUsersUseCase;

  bool hasMoreFollowers = true;
  int currentPage = 1;
  int pageSize = 20;

  FriendsBloc({required this.getSuggestedUsersUseCase})
    : super(FriendsInitial()) {
    on<FetchFriends>(_onFetchUserFollowers);
  }

  // Event handler for fetching followers
  Future<void> _onFetchUserFollowers(
    FetchFriends event,
    Emitter<FriendsState> emit,
  ) async {
    if (event.page == 1) {
      emit(FriendsLoading());
    } else {
      emit(FriendsLoadingMore());
    }

    try {
      final startRecord = (event.page - 1) * pageSize;
      final getSuggestedUsersParams = GetSuggestedUsersParams(
        userId: event.userId,
        startRecord: startRecord,
        pageSize: pageSize,
      );
      final dataState = await getSuggestedUsersUseCase.call(
        params: getSuggestedUsersParams,
      );

      if (dataState is SuccessData) {
        hasMoreFollowers = dataState.data!.length >= pageSize;
        currentPage = event.page;

        if (event.page == 1) {
          emit(FriendsLoaded(followers: dataState.data!));
        } else {
          final List<UserEntity> currentFollowers =
              (state is FriendsLoaded)
                  ? (state as FriendsLoaded).followers
                  : [];
          emit(
            FriendsLoadedWithMore(
              followers: currentFollowers + dataState.data!,
              hasMore: hasMoreFollowers,
            ),
          );
        }
      } else if (dataState is FailedData) {
        throw Exception(dataState.error!.message);
      }
    } catch (e) {
      if (state is FriendsLoaded) {
        emit(
          FriendsErrorWithMore(
            message: e.toString(),
            followers: (state as FriendsLoaded).followers,
          ),
        );
      } else {
        emit(FriendsError(message: e.toString()));
      }
    }
  }
}
