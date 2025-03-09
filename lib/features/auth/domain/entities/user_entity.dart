import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int userId;
  final String name;
  final String userName;
  final String email;
  final String? profilePicture;
  final String? coverPhoto;
  final int followers;
  final int following;
  final int totalLikeCount;
  final bool isFollowing;

  const UserEntity({
    required this.userId,
    required this.name,
    required this.userName,
    required this.email,
    this.profilePicture,
    this.coverPhoto,
    required this.followers,
    required this.following,
    required this.totalLikeCount,
    required this.isFollowing,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        userName,
        email,
        profilePicture,
        coverPhoto,
        followers,
        following,
        totalLikeCount,
        isFollowing
      ];
}
