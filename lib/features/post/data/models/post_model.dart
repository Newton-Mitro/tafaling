import 'package:tafaling/features/auth/data/models/user_model.dart';
import 'package:tafaling/features/post/data/models/attachment_model.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.postId,
    required super.userId,
    super.body,
    required super.privacyId,
    required super.createdBy,
    required UserModel super.creator,
    required List<AttachmentModel> super.attachments,
    required super.likeCount,
    required super.createdAt,
    required super.expireDate,
    required super.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["post_id"] as int,
        userId: json["user_id"] as int,
        body: json["body"] as String?,
        privacyId: json["privacy_id"] as int,
        createdBy: json["created_by"] as int,
        creator: UserModel.fromJson(json["creator"] ?? {}),
        attachments: (json["attachments"] as List<dynamic>? ?? [])
            .map((item) =>
                AttachmentModel.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<AttachmentModel>(), // Ensure proper list casting
        likeCount: json["like_count"] as int,
        createdAt: json["created_at"] as String,
        expireDate: json["expire_date"] as String,
        isLiked: json["is_liked"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "user_id": userId,
        "body": body,
        "privacy_id": privacyId,
        "created_by": createdBy,
        "creator": (creator as UserModel).toJson(),
        "attachments": attachments
            .map((item) => (item as AttachmentModel).toJson())
            .toList(),
        "like_count": likeCount,
        "created_at": createdAt,
        "expire_date": expireDate,
        "is_liked": isLiked,
      };
}
