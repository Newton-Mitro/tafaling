import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';

part 'post_preview_event.dart';
part 'post_preview_state.dart';

class PostPreviewBloc extends Bloc<PostPreviewEvent, PostPreviewState> {
  final LikePostUseCase likePostUseCase;
  final DisLikePostUseCase disLikePostUseCase;

  PostPreviewBloc({
    required this.likePostUseCase,
    required this.disLikePostUseCase,
  }) : super(PostPreviewInitial()) {
    on<LoadPostPreviewEvent>(_onPostPreviewLoadEvent);
    on<PostLikeEvent>(_onPostLikeEvent);
    on<RemovePostLikeEvent>(_onRemovePostLikeEvent);
  }

  Future<void> _onPostPreviewLoadEvent(
    LoadPostPreviewEvent event,
    Emitter<PostPreviewState> emit,
  ) async {
    emit(PostPreviewLoaded(event.post));
  }

  Future<void> _onPostLikeEvent(
    PostLikeEvent event,
    Emitter<PostPreviewState> emit,
  ) async {
    if (state is PostPreviewLoaded) {
      final currentPost = (state as PostPreviewLoaded).post;
      emit(PostPreviewLoading());

      final likeParam = LikePostPrams(postId: event.postId);
      final dataState = await likePostUseCase(params: likeParam);

      if (dataState is SuccessData && dataState.data != null) {
        emit(
          PostPreviewLoaded(
            currentPost.copyWith(
              likeCount: dataState.data!.likeCount,
              isLiked: true,
            ),
          ),
        );
      } else {
        emit(PostPreviewLoaded(currentPost));
      }
    }
  }

  Future<void> _onRemovePostLikeEvent(
    RemovePostLikeEvent event,
    Emitter<PostPreviewState> emit,
  ) async {
    if (state is PostPreviewLoaded) {
      final currentPost = (state as PostPreviewLoaded).post;
      emit(PostPreviewLoading());

      final dislikeParam = DisLikePostPrams(postId: event.postId);
      final dataState = await disLikePostUseCase(params: dislikeParam);

      if (dataState is SuccessData && dataState.data != null) {
        emit(
          PostPreviewLoaded(
            currentPost.copyWith(
              likeCount: dataState.data!.likeCount,
              isLiked: false,
            ),
          ),
        );
      } else {
        emit(PostPreviewLoaded(currentPost));
      }
    }
  }
}
