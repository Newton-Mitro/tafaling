class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        name: json["name"],
        userName: json["user_name"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        followers: json["followers"],
        following: json["following"],
        totalLikeCount: json["total_like_count"],
        isFollowing: json["is_following"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "user_name": userName,
        "email": email,
        "profile_picture": profilePicture,
        "cover_photo": coverPhoto,
        "followers": followers,
        "following": following,
        "total_like_count": totalLikeCount,
        "is_following": isFollowing,
      };
}
