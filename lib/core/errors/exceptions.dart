class ServerException implements Exception {}

class CacheException implements Exception {}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;

  ValidationException(this.errors);
}
