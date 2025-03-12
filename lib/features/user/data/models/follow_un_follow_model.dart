class FollowUnFollowModel {
  final int followingCount;

  FollowUnFollowModel({required this.followingCount});

  factory FollowUnFollowModel.fromJsonToModel(Map<String, dynamic> json) {
    return FollowUnFollowModel(
      followingCount: json['FollowingCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FollowingCount': followingCount,
    };
  }
}
