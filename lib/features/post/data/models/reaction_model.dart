import 'package:tafaling/features/post/domain/entities/reaction_entity.dart';

class ReactionModel extends ReactionEntity {
  const ReactionModel({
    required super.reactionId,
    required super.postId,
    required super.userId,
    required super.type,
    required super.createdAt,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      reactionId: json['reactionId'] as int,
      postId: json['postId'] as int,
      userId: json['userId'] as int,
      type: json['type'] as String,
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

  @override
  ReactionModel copyWith({
    int? reactionId,
    int? postId,
    int? userId,
    String? type,
    DateTime? createdAt,
  }) {
    return ReactionModel(
      reactionId: reactionId ?? this.reactionId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
