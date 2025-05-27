import 'package:tafaling/features/post/domain/entities/comment_entity.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.commentId,
    required super.postId,
    required super.content,
    required UserModel super.createdBy,
    required super.createdAt,
    super.replies = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['UserPostCommentId'] as int,
      postId: json['postId'] as int,
      content: json['postComment'] as String,
      createdBy: UserModel(
        id: json['commentByUserId'],
        name: json['commentByUserName'],
        userName: json['commentByUserName'],
        email: 'unknown', // or provide fallback
        profilePicture: json['commentByProfilePicture'],
        coverPhoto: json['commentByCoverPhoto'],
        followers: json['commentByFollowers'],
        following: json['commentByFollowing'],
        isFollowing: json['isFollowing'], // optional
      ),
      createdAt: DateTime.parse(json['commentDate']),
      replies: const [], // Top-level comment won't include replies directly
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserPostCommentId': commentId,
      'postId': postId,
      'postComment': content,
      'commentByUserId': createdBy.id,
      'commentByUserName': createdBy.name,
      'commentByProfilePicture': createdBy.profilePicture,
      'commentByCoverPhoto': createdBy.coverPhoto,
      'commentByFollowers': createdBy.followers,
      'commentByFollowing': createdBy.following,
      'commentDate': createdAt.toIso8601String(),
      'replies':
          replies.map((reply) => (reply as CommentModel).toJson()).toList(),
    };
  }
}
