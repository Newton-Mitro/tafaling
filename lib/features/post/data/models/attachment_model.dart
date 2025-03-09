import 'package:tafaling/features/post/domain/entities/attachment_entity.dart';

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    required super.attachmentId,
    required super.postId,
    required super.fileName,
    required super.filePath,
    required super.fileURL,
    required super.mimeType,
    required super.createdBy,
    required super.likeCount,
    required super.viewCount,
    required super.shareCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        attachmentId: json["attachment_id"],
        postId: json["post_id"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        fileURL: json["file_url"],
        mimeType: json["mime_type"],
        createdBy: json["created_by"],
        likeCount: json["like_count"],
        viewCount: json["view_count"],
        shareCount: json["share_count"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "attachment_id": attachmentId,
        "post_id": postId,
        "file_name": fileName,
        "file_path": filePath,
        "file_url": fileURL,
        "mime_type": mimeType,
        "created_by": createdBy,
        "like_count": likeCount,
        "view_count": viewCount,
        "share_count": shareCount,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
