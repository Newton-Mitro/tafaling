import 'package:tafaling/features/auth/domain/entities/user_entity.dart';
import 'package:tafaling/features/post/domain/entities/attachment_entity.dart';

class PostEntity {
  final int postId;
  final int userId;
  final String? body;
  final int privacyId;
  final int createdBy;
  final UserEntity creator;
  final List<AttachmentEntity> attachments;
  final int likeCount;
  final String createdAt;
  final String expireDate;
  final bool isLiked;

  PostEntity({
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
}
