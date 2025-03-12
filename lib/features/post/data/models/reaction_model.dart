class ReactionModel {
  final int reactionId;
  final int postId;
  final int userId;
  final String type; // e.g., "like", "love", etc.
  final DateTime createdAt;

  ReactionModel({
    required this.reactionId,
    required this.postId,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  factory ReactionModel.fromJsonToModel(Map<String, dynamic> json) {
    return ReactionModel(
      reactionId: json['reactionId'],
      postId: json['postId'],
      userId: json['userId'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reactionId': reactionId,
      'postId': postId,
      'userId': userId,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
