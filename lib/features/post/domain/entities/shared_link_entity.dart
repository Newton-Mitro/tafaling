class SharedLinkEntity {
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
}
