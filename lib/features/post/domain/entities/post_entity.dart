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
  final String? createdAt;
  final String? expireDate;
  final bool isLiked;

  const PostEntity({
    required this.id,
    required this.userId,
    this.body,
    required this.privacyId,
    required this.createdBy,
    required this.creator,
    required this.attachments,
    required this.likeCount,
    this.createdAt,
    this.expireDate,
    this.isLiked = false,
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
    String? createdAt,
    String? expireDate,
    bool? isLiked,
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
      createdAt: createdAt ?? this.createdAt,
      expireDate: expireDate ?? this.expireDate,
      isLiked: isLiked ?? this.isLiked,
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
    createdAt,
    expireDate,
    isLiked,
  ];
}
