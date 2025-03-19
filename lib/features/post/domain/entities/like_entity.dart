import 'package:equatable/equatable.dart';

class LikeEntity extends Equatable {
  final int likeCount;

  const LikeEntity({required this.likeCount});

  LikeEntity copyWith({int? likeCount}) {
    return LikeEntity(likeCount: likeCount ?? this.likeCount);
  }

  @override
  List<Object?> get props => [likeCount];
}
