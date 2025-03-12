class LikeModel {
  final int likeCount;

  LikeModel({required this.likeCount});

  factory LikeModel.fromJsonToModel(Map<String, dynamic> json) {
    return LikeModel(
      likeCount: json['LikeCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likeCount': likeCount,
    };
  }
}
