import 'package:dartz/dartz.dart';
import 'package:tafaling/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
