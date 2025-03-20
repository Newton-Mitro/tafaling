import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/domain/usecases/get_post_liked_users_usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

part 'post_liked_users_event.dart';
part 'post_liked_users_state.dart';

class PostLikedUsersBloc
    extends Bloc<PostLikedUsersEvent, PostLikedUsersState> {
  final GetPostLikedUsersUsecase getPostLikedUsersUsecase;

  bool hasMoreFollowers = true;
  int currentPage = 1;
  int pageSize = 10;

  PostLikedUsersBloc({required this.getPostLikedUsersUsecase})
    : super(PostLikedUsersInitial()) {
    on<FetchPostLikedUsers>(_onFetchFollowingUsers);
  }

  // Event handler for fetching followers
  Future<void> _onFetchFollowingUsers(
    FetchPostLikedUsers event,
    Emitter<PostLikedUsersState> emit,
  ) async {
    if (event.page == 1) {
      emit(PostLikedUsersLoading());
    } else {
      emit(PostLikedUsersLoadingMore());
    }

    try {
      final startRecord = (event.page - 1) * pageSize;
      final getPostLikedUsersPrams = GetPostLikedUsersPrams(
        postId: event.postId,
        startRecord: startRecord,
        pageSize: pageSize,
      );
      final dataState = await getPostLikedUsersUsecase.call(
        params: getPostLikedUsersPrams,
      );

      if (dataState is SuccessData) {
        hasMoreFollowers = dataState.data!.length >= pageSize;
        currentPage = event.page;

        if (event.page == 1) {
          emit(PostLikedUsersLoaded(followers: dataState.data!));
        } else {
          final List<UserEntity> currentFollowers =
              (state is PostLikedUsersLoaded)
                  ? (state as PostLikedUsersLoaded).followers
                  : [];
          emit(
            PostLikedUsersLoadedWithMore(
              followers: currentFollowers + dataState.data!,
              hasMore: hasMoreFollowers,
            ),
          );
        }
      } else if (dataState is FailedData) {
        throw Exception(dataState.error!.message);
      }
    } catch (e) {
      if (state is PostLikedUsersLoaded) {
        emit(
          PostLikedUsersErrorWithMore(
            message: e.toString(),
            followers: (state as PostLikedUsersLoaded).followers,
          ),
        );
      } else {
        emit(PostLikedUsersError(message: e.toString()));
      }
    }
  }
}
