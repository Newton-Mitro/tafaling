class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Internal Server Error"]);

  @override
  String toString() => "ServerException: $message";
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = "Cache error occurred"]);

  @override
  String toString() => "CacheException: $message";
}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;
  ValidationException(this.errors);

  @override
  String toString() => "ValidationException: $errors";
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "No internet connection"]);

  @override
  String toString() => "NetworkException: $message";
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(
      [this.message = "Unauthorized: Please check your credentials."]);

  @override
  String toString() => "UnauthorizedException: $message";
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException([this.message = "Forbidden: Access is denied."]);

  @override
  String toString() => "ForbiddenException: $message";
}
