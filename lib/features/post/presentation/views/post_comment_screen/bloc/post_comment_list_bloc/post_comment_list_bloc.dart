import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/post/domain/entities/comment_entity.dart';
import 'package:tafaling/features/post/domain/usecases/get_user_post_comments_usecase.dart';

part 'post_comment_list_event.dart';
part 'post_comment_list_state.dart';

class PostCommentListBloc
    extends Bloc<PostCommentListEvent, PostCommentListState> {
  final GetUserPostCommentsUseCase fetchPostComments;

  PostCommentListBloc({required this.fetchPostComments})
    : super(PostCommentListInitial()) {
    on<LoadPostComments>((event, emit) async {
      emit(PostCommentListLoading());
      final result = await fetchPostComments(
        GetUserPostCommentsParams(
          postId: event.postId,
          userId: event.userId,
          parentCommentId: event.parentCommentId ?? -1,
          startRecord: 0,
          pageSize: event.pageSize,
        ),
      );

      result.fold(
        (failure) => emit(PostCommentListError(failure.message)),
        (comments) => emit(
          PostCommentListLoaded(
            comments: comments,
            currentPage: 1,
            pageSize: event.pageSize,
            postId: event.postId,
            userId: event.userId,
            parentCommentId: event.parentCommentId,
          ),
        ),
      );
    });

    on<LoadMorePostComments>((event, emit) async {
      final currentState = state;
      if (currentState is PostCommentListLoaded) {
        final nextStartRecord = currentState.comments.length;
        final nextPage = currentState.currentPage + 1;

        emit(PostCommentListLoadingMore(currentState.comments));

        final result = await fetchPostComments(
          GetUserPostCommentsParams(
            postId: currentState.postId,
            userId: currentState.userId,
            parentCommentId: currentState.parentCommentId ?? -1,
            startRecord: nextStartRecord,
            pageSize: currentState.pageSize,
          ),
        );

        result.fold((failure) => emit(PostCommentListError(failure.message)), (
          newComments,
        ) {
          final updatedList = [...currentState.comments, ...newComments];
          emit(
            PostCommentListLoaded(
              comments: updatedList,
              currentPage: nextPage,
              pageSize: currentState.pageSize,
              postId: currentState.postId,
              userId: currentState.userId,
              parentCommentId: currentState.parentCommentId,
            ),
          );
        });
      }
    });
  }
}
