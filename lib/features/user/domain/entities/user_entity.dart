import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String email;
  final DateTime? emailVerifiedAt;
  final String? profilePicture;
  final String? coverPhoto;
  final int followers;
  final int following;
  final int totalLikeCount;
  final bool isFollowing;
  final int friendshipStatus;

  const UserEntity({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    this.coverPhoto,
    this.followers = 0,
    this.following = 0,
    this.totalLikeCount = 0,
    this.isFollowing = false,
    this.friendshipStatus = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        userName,
        email,
        emailVerifiedAt,
        profilePicture,
        coverPhoto,
        followers,
        following,
        totalLikeCount,
        isFollowing,
        friendshipStatus
      ];
}
