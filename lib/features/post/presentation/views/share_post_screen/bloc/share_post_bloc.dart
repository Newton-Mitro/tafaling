import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/post/domain/usecases/share_post_usecase.dart';

part 'share_post_event.dart';
part 'share_post_state.dart';

class SharePostBloc extends Bloc<SharePostEvent, SharePostState> {
  final SharePostUseCase sharePostUseCase;

  SharePostBloc({required this.sharePostUseCase}) : super(SharePostInitial()) {
    on<SharePostSubmitted>(_onSharePostSubmitted);
  }

  Future<void> _onSharePostSubmitted(
    SharePostSubmitted event,
    Emitter<SharePostState> emit,
  ) async {
    emit(SharePostLoading());

    final result = await sharePostUseCase.call(
      SharePostParams(
        privacyId: event.privacyId,
        body: event.body,
        postId: event.postId,
      ),
    );

    result.fold(
      (failure) => emit(SharePostFailure(failure.message)),
      (message) => emit(SharePostSuccess(message)),
    );
  }
}
