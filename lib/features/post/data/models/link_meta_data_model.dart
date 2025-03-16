class LinkMetadataModel {
  final String url;
  final String title;
  final String description;
  final String image;

  LinkMetadataModel({
    required this.url,
    required this.title,
    required this.description,
    required this.image,
  });

  factory LinkMetadataModel.fromJson(Map<String, dynamic> json) {
    return LinkMetadataModel(
      url: json['metadata']['url'] ?? '',
      title: json['metadata']['title'] ?? '',
      description: json['metadata']['description'] ?? '',
      image: json['metadata']['image'] ?? '',
    );
  }
}

class ApiResponse {
  final LinkMetadataModel metadata;
  final String message;
  final dynamic errors;

  ApiResponse({
    required this.metadata,
    required this.message,
    required this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      metadata: LinkMetadataModel.fromJson(json),
      message: json['message'] ?? '',
      errors: json['errors'],
    );
  }
}
