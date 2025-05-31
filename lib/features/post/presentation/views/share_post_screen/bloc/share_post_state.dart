part of 'share_post_bloc.dart';

abstract class SharePostState extends Equatable {
  const SharePostState();

  @override
  List<Object?> get props => [];
}

class SharePostInitial extends SharePostState {}

class SharePostLoading extends SharePostState {}

class SharePostSuccess extends SharePostState {
  final String message;

  const SharePostSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SharePostFailure extends SharePostState {
  final String error;

  const SharePostFailure(this.error);

  @override
  List<Object?> get props => [error];
}
