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

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
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

  Map<String, dynamic> toJson() {
    return {
      "attachmentId": attachmentId,
      "postId": postId,
      "fileName": fileName,
      "filePath": filePath,
      "fileURL": fileURL,
      "mimeType": mimeType,
      "createdBy": createdBy,
      "likeCount": likeCount,
      "viewCount": viewCount,
      "shareCount": shareCount,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  @override
  AttachmentModel copyWith({
    int? attachmentId,
    int? postId,
    String? fileName,
    String? filePath,
    String? fileURL,
    String? mimeType,
    int? createdBy,
    int? likeCount,
    int? viewCount,
    int? shareCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return AttachmentModel(
      attachmentId: attachmentId ?? this.attachmentId,
      postId: postId ?? this.postId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileURL: fileURL ?? this.fileURL,
      mimeType: mimeType ?? this.mimeType,
      createdBy: createdBy ?? this.createdBy,
      likeCount: likeCount ?? this.likeCount,
      viewCount: viewCount ?? this.viewCount,
      shareCount: shareCount ?? this.shareCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
