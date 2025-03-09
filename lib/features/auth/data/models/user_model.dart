import 'package:tafaling/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.name,
    required super.userName,
    required super.email,
    super.profilePicture,
    super.coverPhoto,
    required super.followers,
    required super.following,
    required super.totalLikeCount,
    required super.isFollowing,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      userName: json['userName'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      coverPhoto: json['coverPhoto'],
      followers: json['followers'],
      following: json['following'],
      totalLikeCount: json['totalLikeCount'],
      isFollowing: json['isFollowing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'userName': userName,
      'email': email,
      'profilePicture': profilePicture,
      'coverPhoto': coverPhoto,
      'followers': followers,
      'following': following,
      'totalLikeCount': totalLikeCount,
      'isFollowing': isFollowing,
    };
  }
}
