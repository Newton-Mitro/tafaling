part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPostEvent extends CreatePostEvent {
  final int privacyId;
  final String body;
  final List<File> attachments;

  const SubmitPostEvent({
    required this.privacyId,
    required this.body,
    required this.attachments,
  });

  @override
  List<Object?> get props => [privacyId, body, attachments];
}
