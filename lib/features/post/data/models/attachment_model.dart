class AttachmentModel {
  final int attachmentId;
  final int postId;
  final String fileName;
  final String filePath;
  final String fileURL;
  final String mimeType;
  final int createdBy;
  final int likeCount;
  final int viewCount;
  final int shareCount;
  final String createdAt;
  final String updatedAt;

  AttachmentModel({
    required this.attachmentId,
    required this.postId,
    required this.fileName,
    required this.filePath,
    required this.fileURL,
    required this.mimeType,
    required this.createdBy,
    required this.likeCount,
    required this.viewCount,
    required this.shareCount,
    required this.createdAt,
    required this.updatedAt,
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
