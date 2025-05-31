part of 'share_post_bloc.dart';

abstract class SharePostEvent extends Equatable {
  const SharePostEvent();

  @override
  List<Object?> get props => [];
}

class SharePostSubmitted extends SharePostEvent {
  final int privacyId;
  final String body;
  final int postId;

  const SharePostSubmitted({
    required this.privacyId,
    required this.body,
    required this.postId,
  });

  @override
  List<Object?> get props => [privacyId, body, postId];
}
