import 'package:tafaling/features/post/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.commentId,
    required super.postId,
    required super.content,
    required super.createdBy,
    required super.createdAt,
    super.replies = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] as int,
      postId: json['postId'] as int,
      content: json['content'] as String,
      createdBy: json['createdBy'] as int,
      createdAt: DateTime.parse(json['createdAt']),
      replies: (json['replies'] as List<dynamic>?)
              ?.map((reply) => CommentModel.fromJson(reply))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'postId': postId,
      'content': content,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'replies':
          replies.map((reply) => (reply as CommentModel).toJson()).toList(),
    };
  }

  CommentModel copyWith({
    int? commentId,
    int? postId,
    String? content,
    int? createdBy,
    DateTime? createdAt,
    List<CommentModel>? replies,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
    );
  }
}
