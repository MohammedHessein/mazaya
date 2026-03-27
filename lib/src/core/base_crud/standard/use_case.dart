import 'package:multiple_result/multiple_result.dart';

import 'package:mazaya/src/core/error/failure.dart';

abstract class UseCase<T, Param> {
  Future<Result<Type, Failure>> call(Param param);
  // i use [] to make param optional
}

abstract class UseCaseWithoutParam<T> {
  Future<Result<Type, Failure>> call();
  // i use [] to make param optional
}
