import 'package:equatable/equatable.dart';

class PostLikeEntity extends Equatable {
  final int postId;
  final int postOwnerId;
  final String postOwnerName;
  final bool isFollowing;
  final int overallCount;
  final int likedByUserId;
  final String likedByUserName;
  final String likedByUserProfile;
  final String likedByUserCover;
  final int likedByUserFollowing;
  final int likedByUserFollowers;
  final String postedAt;
  final String postLikedAt;

  const PostLikeEntity({
    required this.postId,
    required this.postOwnerId,
    required this.postOwnerName,
    required this.isFollowing,
    required this.overallCount,
    required this.likedByUserId,
    required this.likedByUserName,
    required this.likedByUserProfile,
    required this.likedByUserCover,
    required this.likedByUserFollowing,
    required this.likedByUserFollowers,
    required this.postedAt,
    required this.postLikedAt,
  });

  @override
  List<Object?> get props => [
    postId,
    postOwnerId,
    postOwnerName,
    isFollowing,
    overallCount,
    likedByUserId,
    likedByUserName,
    likedByUserProfile,
    likedByUserCover,
    likedByUserFollowing,
    likedByUserFollowers,
    postedAt,
    postLikedAt,
  ];
}
