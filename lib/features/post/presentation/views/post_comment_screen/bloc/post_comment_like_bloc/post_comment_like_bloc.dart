import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/post/domain/usecases/delete_post_comment_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_comment_usecase.dart';

part 'post_comment_like_event.dart';
part 'post_comment_like_state.dart';

class PostCommentLikeBloc
    extends Bloc<PostCommentLikeEvent, PostCommentLikeState> {
  final LikePostCommentUseCase likePostComment;
  final DeletePostCommentUseCase removeCommentLike;

  PostCommentLikeBloc({
    required this.likePostComment,
    required this.removeCommentLike,
  }) : super(CommentLikeInitial()) {
    on<LikeComment>((event, emit) async {
      emit(CommentLikeLoading());
      final result = await likePostComment(
        LikePostCommentParams(commentId: event.commentId, userId: event.userId),
      );
      result.fold(
        (failure) => emit(CommentLikeError(failure.message)),
        (_) => emit(CommentLikeSuccess()),
      );
    });

    on<UnlikeComment>((event, emit) async {
      emit(CommentLikeLoading());
      final result = await removeCommentLike(
        DeletePostCommentParams(
          commentId: event.commentId,
          userId: event.userId,
        ),
      );
      result.fold(
        (failure) => emit(CommentLikeError(failure.message)),
        (_) => emit(CommentLikeSuccess()),
      );
    });
  }
}
