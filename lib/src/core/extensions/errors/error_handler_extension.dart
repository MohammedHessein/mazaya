import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../error/exceptions.dart';
import '../../error/failure.dart';

extension ErrorHandler<T> on Future<T> {
  Future<Result<T, Failure>> handleCallbackWithFailure() async {
    try {
      return await _defaultHandler();
    } catch (e, s) {
      _logUnexpectedError(e, s);
      return Error(Failure(_getErrorMessage(e)));
    }
  }

  Future<Result<T, Failure>> _defaultHandler() async {
    try {
      final result = await this;
      return Success(result);
    } on BlockedException catch (e) {
      return Error(Failure(e.message));
    } on UnauthorizedException catch (e) {
      return Error(Failure(e.message));
    } on ServerException catch (e) {
      return Error(Failure(e.message));
    }
  }

  void _logUnexpectedError(Object e, StackTrace s) {
    if (kDebugMode) {
      log('Unexpected error: ${e.toString()}', stackTrace: s);
    }
  }

  String _getErrorMessage(Object e) => e.toString();
}
