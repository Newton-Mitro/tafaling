import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/get_suggested_users_usecase.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetSuggestedUsersUseCase getSuggestedUsersUseCase;

  bool hasMoreFollowers = true;
  int currentPage = 1;
  int pageSize = 10;

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
        getSuggestedUsersParams,
      );

      dataState.fold((l) => emit(FriendsError(message: l.message)), (r) {
        if (r.isEmpty) {
          hasMoreFollowers = false;
          emit(FriendsLoaded(followers: r));
        } else {
          hasMoreFollowers = true;
          emit(FriendsLoaded(followers: r));
        }
      });
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
