import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/post/domain/usecases/create_post_usecase.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUseCase createPostUseCase;

  CreatePostBloc({required this.createPostUseCase})
    : super(CreatePostInitial()) {
    on<SubmitPostEvent>(_onSubmitPost);
  }

  Future<void> _onSubmitPost(
    SubmitPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(CreatePostLoading());

    final result = await createPostUseCase(
      CreatePostParams(
        privacyId: event.privacyId,
        body: event.body,
        attachments: event.attachments,
      ),
    );

    result.fold(
      (failure) {
        emit(CreatePostFailure(failure.message));
      },
      (message) {
        emit(CreatePostSuccess(message));
      },
    );
  }
}
