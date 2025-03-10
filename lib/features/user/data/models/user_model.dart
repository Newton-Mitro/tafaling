import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.userName,
    required super.email,
    super.emailVerifiedAt,
    super.profilePicture,
    super.coverPhoto,
    super.followers,
    super.following,
    super.totalLikeCount,
    super.isFollowing,
    super.friendshipStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      userName: json['user_name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      profilePicture: json['profile_picture'],
      coverPhoto: json['cover_photo'],
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalLikeCount: json['total_like_count'] ?? 0,
      isFollowing: json['is_following'] ?? false,
      friendshipStatus: json['friendship_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'profilePicture': profilePicture,
      'coverPhoto': coverPhoto,
      'followers': followers,
      'following': following,
      'totalLikeCount': totalLikeCount,
      'isFollowing': isFollowing,
      'friendshipStatus': friendshipStatus,
    };
  }
}
