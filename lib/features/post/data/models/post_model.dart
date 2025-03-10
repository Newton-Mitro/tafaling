import 'package:tafaling/features/post/data/models/attachment_model.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    super.body,
    required super.privacyId,
    required super.createdBy,
    required UserModel super.creator,
    required List<AttachmentModel> super.attachments,
    required super.likeCount,
    super.createdAt,
    super.expireDate,
    super.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["postId"] as int,
        userId: json["userId"] as int,
        body: json["body"] as String?,
        privacyId: json["privacyId"] as int,
        createdBy: json["createdBy"] as int,
        creator: UserModel.fromJson(json["creator"] ?? {}),
        attachments: (json["attachments"] as List<dynamic>? ?? [])
            .map((item) =>
                AttachmentModel.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<AttachmentModel>(),
        likeCount: json["likeCount"] ?? 0,
        createdAt: json["createdAt"] as String?,
        expireDate: json["expireDate"] as String?,
        isLiked: (json["isLiked"] ?? 0) == 1, // Convert int to bool
      );
}
