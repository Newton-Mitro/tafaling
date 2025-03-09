import 'package:equatable/equatable.dart';

class AttachmentEntity extends Equatable {
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

  const AttachmentEntity({
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
