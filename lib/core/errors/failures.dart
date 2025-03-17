import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

final class ValidationFailure extends Failure {
  final Map<String, dynamic> errors;

  const ValidationFailure(this.errors, [super.message = "Validation failed"]);

  @override
  List<Object?> get props => [message, errors];
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server failure"]);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache failure"]);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No internet connection"]);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(
      [super.message = "Unauthorized: Please check your credentials."]);
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message = "Forbidden: Access is denied."]);
}
