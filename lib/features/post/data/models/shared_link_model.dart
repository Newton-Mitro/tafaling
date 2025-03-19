import 'package:tafaling/features/post/domain/entities/shared_link_entity.dart';

class SharedLinkModel extends SharedLinkEntity {
  const SharedLinkModel({
    required super.url,
    required super.title,
    super.description,
    super.thumbnail,
  });

  factory SharedLinkModel.fromJson(Map<String, dynamic> json) {
    return SharedLinkModel(
      url: json['url'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
    };
  }

  @override
  SharedLinkModel copyWith({
    String? url,
    String? title,
    String? description,
    String? thumbnail,
  }) {
    return SharedLinkModel(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}
