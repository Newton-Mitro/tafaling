import 'package:equatable/equatable.dart';

class AttachmentEntity extends Equatable {
  final int attachmentId;
  final int postId;
  final String? fileName;
  final String? filePath;
  final String fileURL;
  final String mimeType;
  final int createdBy;
  final int likeCount;
  final int viewCount;
  final int shareCount;
  final String? createdAt;
  final String? updatedAt;

  const AttachmentEntity({
    required this.attachmentId,
    required this.postId,
    this.fileName,
    this.filePath,
    required this.fileURL,
    required this.mimeType,
    this.createdBy = 0,
    this.likeCount = 0,
    this.viewCount = 0,
    this.shareCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        attachmentId,
        postId,
        fileName,
        filePath,
        fileURL,
        mimeType,
        createdBy,
        likeCount,
        viewCount,
        shareCount,
        createdAt,
        updatedAt,
      ];
}
