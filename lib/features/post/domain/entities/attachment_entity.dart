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

  AttachmentEntity copyWith({
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
    return AttachmentEntity(
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
