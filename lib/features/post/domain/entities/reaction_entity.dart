class ReactionEntity {
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
}
