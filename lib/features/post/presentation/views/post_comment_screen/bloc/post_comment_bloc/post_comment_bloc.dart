import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/post/domain/usecases/comment_on_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/delete_post_comment_usecase.dart';

part 'post_comment_event.dart';
part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  final CommentOnPostUseCase commentOnPost;
  final DeletePostCommentUseCase deleteComment;

  PostCommentBloc({required this.commentOnPost, required this.deleteComment})
    : super(PostCommentInitial()) {
    on<SubmitPostComment>((event, emit) async {
      emit(PostCommentSubmitting());

      final result = await commentOnPost(
        CommentOnPostParams(
          parentCommentId: event.parentId ?? 0,
          commentBody: event.comment,
          postId: event.postId,
        ),
      );
      result.fold(
        (failure) => emit(PostCommentError(failure.message)),
        (_) => emit(PostCommentSubmitted()),
      );
    });

    on<DeletePostComment>((event, emit) async {
      emit(PostCommentSubmitting());
      final result = await deleteComment(
        DeletePostCommentParams(
          commentId: event.commentId,
          userId: event.userId,
        ),
      );
      result.fold(
        (failure) => emit(PostCommentError(failure.message)),
        (_) => emit(PostCommentSubmitted()),
      );
    });
  }
}
