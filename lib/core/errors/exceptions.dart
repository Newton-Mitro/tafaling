class ServerException implements Exception {}

class CacheException implements Exception {}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;

  ValidationException(this.errors);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "No internet connection"]);
}
