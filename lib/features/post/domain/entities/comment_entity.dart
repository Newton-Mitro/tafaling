class CommentEntity {
  final int commentId;
  final int postId;
  final String content;
  final int createdBy;
  final DateTime createdAt;
  final List<CommentEntity> replies;

  const CommentEntity({
    required this.commentId,
    required this.postId,
    required this.content,
    required this.createdBy,
    required this.createdAt,
    this.replies = const [],
  });
}
