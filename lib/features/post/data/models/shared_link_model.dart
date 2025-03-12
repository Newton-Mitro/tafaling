class SharedLinkModel {
  final String url;
  final String title;
  final String? description;
  final String? thumbnail;

  SharedLinkModel({
    required this.url,
    required this.title,
    this.description,
    this.thumbnail,
  });

  factory SharedLinkModel.fromJsonToModel(Map<String, dynamic> json) {
    return SharedLinkModel(
      url: json['url'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
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
}
