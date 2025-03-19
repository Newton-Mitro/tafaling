import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
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

  CommentEntity copyWith({
    int? commentId,
    int? postId,
    String? content,
    int? createdBy,
    DateTime? createdAt,
    List<CommentEntity>? replies,
  }) {
    return CommentEntity(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
    );
  }

  @override
  List<Object?> get props => [
    commentId,
    postId,
    content,
    createdBy,
    createdAt,
    replies,
  ];
}
