import 'package:equatable/equatable.dart';

class ReactionEntity extends Equatable {
  final int reactionId;
  final int postId;
  final int userId;
  final String type; // e.g., "like", "love", etc.
  final DateTime createdAt;

  const ReactionEntity({
    required this.reactionId,
    required this.postId,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  ReactionEntity copyWith({
    int? reactionId,
    int? postId,
    int? userId,
    String? type,
    DateTime? createdAt,
  }) {
    return ReactionEntity(
      reactionId: reactionId ?? this.reactionId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [reactionId, postId, userId, type, createdAt];
}
