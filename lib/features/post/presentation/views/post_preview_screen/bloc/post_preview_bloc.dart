import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    final currentState = state;
    if (currentState is PostPreviewLoaded) {
      emit(PostPreviewLoading());

      final result = await likePostUseCase(LikePostPrams(postId: event.postId));
      result.fold(
        (failure) => emit(PostPreviewError(message: failure.message)),
        (response) {
          emit(
            PostPreviewLoaded(
              currentState.post.copyWith(
                likeCount: response.likeCount,
                isLiked: true,
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> _onRemovePostLikeEvent(
    RemovePostLikeEvent event,
    Emitter<PostPreviewState> emit,
  ) async {
    final currentState = state;
    if (currentState is PostPreviewLoaded) {
      emit(PostPreviewLoading());

      final result = await disLikePostUseCase(
        DisLikePostPrams(postId: event.postId),
      );
      result.fold(
        (failure) => emit(PostPreviewError(message: failure.message)),
        (response) {
          emit(
            PostPreviewLoaded(
              currentState.post.copyWith(
                likeCount: response.likeCount,
                isLiked: false,
              ),
            ),
          );
        },
      );
    }
  }
}
