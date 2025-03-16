import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/errors/failures.dart';

abstract class ResponseState<T> {
  final T? data;
  final Failure? error;
  final ValidationException? errors;

  const ResponseState({this.data, this.error, this.errors});
}

class ResponseSuccess<T> extends ResponseState<T> {
  const ResponseSuccess(T data) : super(data: data);
}

class ResponseFailed<T> extends ResponseState<T> {
  const ResponseFailed(Failure error) : super(error: error);
}

class ValidationFailed<T> extends ResponseState<T> {
  const ValidationFailed(ValidationException errors) : super(errors: errors);
}
