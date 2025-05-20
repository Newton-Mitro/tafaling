import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/get_suggested_users_usecase.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetSuggestedUsersUseCase getSuggestedUsersUseCase;

  int currentPage = 1;
  final int pageSize = 10;
  bool hasMoreFollowers = true;
  bool isLoading = false;

  FriendsBloc({required this.getSuggestedUsersUseCase})
    : super(FriendsInitial()) {
    on<FetchFriends>(_onFetchUserFollowers);
  }

  Future<void> _onFetchUserFollowers(
    FetchFriends event,
    Emitter<FriendsState> emit,
  ) async {
    if (isLoading || !hasMoreFollowers) return;

    isLoading = true;

    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(FriendsLoading());
    } else {
      emit(FriendsLoadingMore(followers: (state as FriendsLoaded).followers));
    }

    try {
      final startRecord = (event.page - 1) * pageSize;
      final result = await getSuggestedUsersUseCase.call(
        GetSuggestedUsersParams(
          userId: event.userId,
          startRecord: startRecord,
          pageSize: pageSize,
        ),
      );

      result.fold(
        (failure) {
          if (state is FriendsLoaded && !isFirstPage) {
            emit(
              FriendsErrorWithMore(
                message: failure.message,
                followers: (state as FriendsLoaded).followers,
              ),
            );
          } else {
            emit(FriendsError(message: failure.message));
          }
        },
        (newFollowers) {
          final existingFollowers =
              (state is FriendsLoaded)
                  ? (state as FriendsLoaded).followers
                  : <UserEntity>[];

          final updatedFollowers =
              isFirstPage
                  ? newFollowers
                  : [...existingFollowers, ...newFollowers];

          hasMoreFollowers = newFollowers.length == pageSize;
          currentPage = event.page;

          emit(FriendsLoaded(followers: updatedFollowers));
        },
      );
    } catch (e) {
      if (state is FriendsLoaded && !isFirstPage) {
        emit(
          FriendsErrorWithMore(
            message: e.toString(),
            followers: (state as FriendsLoaded).followers,
          ),
        );
      } else {
        emit(FriendsError(message: e.toString()));
      }
    } finally {
      isLoading = false;
    }
  }
}
