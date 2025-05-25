import 'dart:io';

import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class UpdateCoverPhotoParams {
  final File coverPhoto;

  UpdateCoverPhotoParams(this.coverPhoto);
}

class UpdateCoverPhotoUseCase
    implements UseCase<UserEntity, UpdateCoverPhotoParams> {
  final UserRepository repository;

  UpdateCoverPhotoUseCase(this.repository);

  @override
  ResultFuture<UserEntity> call(UpdateCoverPhotoParams params) {
    return repository.updateCoverPhoto(params.coverPhoto);
  }
}
