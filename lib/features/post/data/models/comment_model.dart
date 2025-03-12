class CommentModel {
  final int commentId;
  final int postId;
  final String content;
  final int createdBy;
  final DateTime createdAt;
  final List<CommentModel> replies; // Nested comments

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.content,
    required this.createdBy,
    required this.createdAt,
    this.replies = const [],
  });

  factory CommentModel.fromJsonToModel(Map<String, dynamic> json) {
    var repliesFromJson = json['replies'] as List;
    List<CommentModel> replyList =
        repliesFromJson.map((i) => CommentModel.fromJsonToModel(i)).toList();

    return CommentModel(
      commentId: json['commentId'],
      postId: json['postId'],
      content: json['content'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      replies: replyList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'postId': postId,
      'content': content,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'replies': replies.map((reply) => reply.toJson()).toList(),
    };
  }
}
