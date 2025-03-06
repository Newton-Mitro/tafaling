import 'package:tafaling/features/auth/data/models/user_model.dart';
import 'package:tafaling/features/post/data/models/attachment_model.dart';

class PostModel {
  final int postId;
  final int userId;
  final String? body;
  final int privacyId;
  final int createdBy;
  final UserModel creator;
  final List<AttachmentModel> attachments;
  final int likeCount;
  final String createdAt;
  final String expireDate;
  final bool isLiked;

  PostModel({
    required this.postId,
    required this.userId,
    required this.body,
    required this.privacyId,
    required this.createdBy,
    required this.creator,
    required this.attachments,
    required this.likeCount,
    required this.createdAt,
    required this.expireDate,
    required this.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["post_id"],
        userId: json["user_id"],
        body: json["body"],
        privacyId: json["privacy_id"],
        createdBy: json["created_by"],
        creator: UserModel.fromJson(json["creator"]),
        attachments: (json["attachments"] as List)
            .map((item) => AttachmentModel.fromJson(item))
            .toList(),
        likeCount: json["like_count"],
        createdAt: json["created_at"],
        expireDate: json["expire_date"],
        isLiked: json["is_liked"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "user_id": userId,
        "body": body,
        "privacy_id": privacyId,
        "created_by": createdBy,
        "creator": creator.toJson(),
        "attachments": attachments.map((item) => item.toJson()).toList(),
        "like_count": likeCount,
        "created_at": createdAt,
        "expire_date": expireDate,
        "is_liked": isLiked,
      };
}
