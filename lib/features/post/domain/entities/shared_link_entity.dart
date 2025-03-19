import 'package:equatable/equatable.dart';

class SharedLinkEntity extends Equatable {
  final String url;
  final String title;
  final String? description;
  final String? thumbnail;

  const SharedLinkEntity({
    required this.url,
    required this.title,
    this.description,
    this.thumbnail,
  });

  SharedLinkEntity copyWith({
    String? url,
    String? title,
    String? description,
    String? thumbnail,
  }) {
    return SharedLinkEntity(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [url, title, description, thumbnail];
}
