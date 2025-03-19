import 'package:tafaling/features/post/domain/entities/like_entity.dart';

class LikeModel extends LikeEntity {
  const LikeModel({required super.likeCount});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(likeCount: json['LikeCount'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'LikeCount': likeCount};
  }

  @override
  LikeModel copyWith({int? likeCount}) {
    return LikeModel(likeCount: likeCount ?? this.likeCount);
  }
}
