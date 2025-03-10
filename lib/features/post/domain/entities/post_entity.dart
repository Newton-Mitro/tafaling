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
  final String createdAt;
  final String expireDate;
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
    required this.createdAt,
    required this.expireDate,
    required this.isLiked,
  });

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
