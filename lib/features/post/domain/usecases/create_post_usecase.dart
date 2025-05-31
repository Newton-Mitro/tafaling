import 'dart:io';

import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class CreatePostParams {
  final int privacyId;
  final String body;
  final List<File> attachments;

  CreatePostParams({
    required this.privacyId,
    required this.body,
    required this.attachments,
  });
}

class CreatePostUseCase implements UseCase<String, CreatePostParams> {
  final PostRepository repository;

  CreatePostUseCase({required this.repository});

  @override
  ResultFuture<String> call(CreatePostParams params) {
    return repository.createPost(
      params.privacyId,
      params.body,
      params.attachments,
    );
  }
}
