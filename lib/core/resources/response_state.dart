import 'package:dio/dio.dart';

abstract class ResponseState<T> {
  final T? data;
  final DioException? error;

  const ResponseState({this.data, this.error});
}

class ResponseSuccess<T> extends ResponseState<T> {
  const ResponseSuccess(T data) : super(data: data);
}

class ResponseFailed<T> extends ResponseState<T> {
  const ResponseFailed(DioException error) : super(error: error);
}
