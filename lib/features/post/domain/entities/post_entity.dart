import 'package:equatable/equatable.dart';
import 'package:tafaling/features/post/domain/entities/attachment_entity.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class PostEntity extends Equatable {
  final int id;
  final int userId;
  final String? body;
  final int privacyId;
  final int createdBy;
  final UserEntity creator;
  final List<AttachmentEntity> attachments;
  final int likeCount;
  final int shareCount;
  final int commentCount;
  final String? createdAt;
  final String? expireDate;
  final bool isLiked;
  final List<PostEntity> shareDetails;

  const PostEntity({
    required this.id,
    required this.userId,
    this.body,
    required this.privacyId,
    required this.createdBy,
    required this.creator,
    required this.attachments,
    required this.likeCount,
    required this.shareCount,
    required this.commentCount,
    this.createdAt,
    this.expireDate,
    this.isLiked = false,
    required this.shareDetails,
  });

  PostEntity copyWith({
    int? id,
    int? userId,
    String? body,
    int? privacyId,
    int? createdBy,
    UserEntity? creator,
    List<AttachmentEntity>? attachments,
    int? likeCount,
    int? shareCount,
    int? commentCount,
    String? createdAt,
    String? expireDate,
    bool? isLiked,
    List<PostEntity>? shareDetails,
  }) {
    return PostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      body: body ?? this.body,
      privacyId: privacyId ?? this.privacyId,
      createdBy: createdBy ?? this.createdBy,
      creator: creator ?? this.creator,
      attachments: attachments ?? this.attachments,
      likeCount: likeCount ?? this.likeCount,
      shareCount: shareCount ?? this.shareCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      expireDate: expireDate ?? this.expireDate,
      isLiked: isLiked ?? this.isLiked,
      shareDetails: shareDetails ?? this.shareDetails,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    body,
    privacyId,
    createdBy,
    creator,
    attachments,
    likeCount,
    shareCount,
    commentCount,
    createdAt,
    expireDate,
    isLiked,
    shareDetails,
  ];
}
