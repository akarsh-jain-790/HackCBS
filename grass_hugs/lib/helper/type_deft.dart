import 'package:fpdart/fpdart.dart';
import 'package:grass_hugs/helper/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
