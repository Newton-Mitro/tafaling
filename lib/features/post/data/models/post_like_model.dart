import 'package:tafaling/features/post/domain/entities/post_like_entity.dart';

class PostLikeModel extends PostLikeEntity {
  const PostLikeModel({
    required super.postId,
    required super.postOwnerId,
    required super.postOwnerName,
    required super.isFollowing,
    required super.overallCount,
    required super.likedByUserId,
    required super.likedByUserName,
    required super.likedByUserProfile,
    required super.likedByUserCover,
    required super.likedByUserFollowing,
    required super.likedByUserFollowers,
    required super.postedAt,
    required super.postLikedAt,
  });

  PostLikeModel copyWith({
    int? postId,
    int? postOwnerId,
    String? postOwnerName,
    bool? isFollowing,
    int? overallCount,
    int? likedByUserId,
    String? likedByUserName,
    String? likedByUserProfile,
    String? likedByUserCover,
    int? likedByUserFollowing,
    int? likedByUserFollowers,
    String? postedAt,
    String? postLikedAt,
  }) {
    return PostLikeModel(
      postId: postId ?? this.postId,
      postOwnerId: postOwnerId ?? this.postOwnerId,
      postOwnerName: postOwnerName ?? this.postOwnerName,
      isFollowing: isFollowing ?? this.isFollowing,
      overallCount: overallCount ?? this.overallCount,
      likedByUserId: likedByUserId ?? this.likedByUserId,
      likedByUserName: likedByUserName ?? this.likedByUserName,
      likedByUserProfile: likedByUserProfile ?? this.likedByUserProfile,
      likedByUserCover: likedByUserCover ?? this.likedByUserCover,
      likedByUserFollowing: likedByUserFollowing ?? this.likedByUserFollowing,
      likedByUserFollowers: likedByUserFollowers ?? this.likedByUserFollowers,
      postedAt: postedAt ?? this.postedAt,
      postLikedAt: postLikedAt ?? this.postLikedAt,
    );
  }
}
