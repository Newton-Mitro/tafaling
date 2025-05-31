part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object?> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  final String message;

  const CreatePostSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreatePostFailure extends CreatePostState {
  final String error;

  const CreatePostFailure(this.error);

  @override
  List<Object?> get props => [error];
}
