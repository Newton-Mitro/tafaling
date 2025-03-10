import 'package:tafaling/features/post/domain/entities/attachment_entity.dart';

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    required super.attachmentId,
    required super.postId,
    super.fileName,
    super.filePath,
    required super.fileURL,
    required super.mimeType,
    required super.createdBy,
    required super.likeCount,
    required super.viewCount,
    required super.shareCount,
    super.createdAt,
    super.updatedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        attachmentId: json["attachmentId"] as int,
        postId: json["postId"] as int,
        fileName: json["fileName"] as String?,
        filePath: json["filePath"] as String?,
        fileURL: json["fileURL"] as String,
        mimeType: json["mimeType"] as String,
        createdBy: json["createdBy"] ?? 0,
        likeCount: json["likeCount"] ?? 0,
        viewCount: json["viewCount"] ?? 0,
        shareCount: json["shareCount"] ?? 0,
        createdAt: json["createdAt"] as String?,
        updatedAt: json["updatedAt"] as String?,
      );
}
