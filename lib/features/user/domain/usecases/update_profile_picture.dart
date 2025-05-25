import 'dart:io';

import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';
import 'package:tafaling/core/usecases/usecase.dart';

class UpdateProfilePictureParams {
  final File profilePhoto;

  UpdateProfilePictureParams(this.profilePhoto);
}

class UpdateProfilePictureUseCase
    implements UseCase<UserEntity, UpdateProfilePictureParams> {
  final UserRepository repository;

  UpdateProfilePictureUseCase(this.repository);

  @override
  ResultFuture<UserEntity> call(UpdateProfilePictureParams params) {
    return repository.updateProfilePicture(params.profilePhoto);
  }
}
