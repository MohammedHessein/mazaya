import 'package:equatable/equatable.dart';

import '../../config/language/locale_keys.g.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}

class FetchDataException extends ServerException {
  const FetchDataException(super.message);
}

class BadRequestException extends ServerException {
  const BadRequestException(super.message);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.message);
}

class NotFoundException extends ServerException {
  const NotFoundException(super.message);
}

class ConflictException extends ServerException {
  const ConflictException(super.message);
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException([String? message])
      : super(message ?? LocaleKeys.checkInternet);
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException([String? message])
      : super(message ?? LocaleKeys.checkInternet);
}

class CacheException implements Exception {}

class ForbiddenException extends ServerException {
  const ForbiddenException(super.message);
}

class BlockedException extends ServerException {
  const BlockedException(super.message);
}

class NeedActiveException extends ServerException {
  const NeedActiveException(super.message);
}
