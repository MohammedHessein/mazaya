import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mazaya/src/config/language/languages.dart';

import '../../config/res/config_imports.dart';
import 'backend_configuation.dart';

class ConfigurationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      HttpHeaders.acceptHeader: ConstantManager.acceptHeader,
      HttpHeaders.acceptLanguageHeader:
          Languages.currentLanguage.locale.languageCode,
    });

    if (options.data is! FormData) {
      options.headers[HttpHeaders.contentTypeHeader] =
          ConstantManager.acceptHeader;
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (BackendConfiguation.type.isPhp) {
      _handleError(response);
    }
    handler.next(response);
  }

  void _handleError(Response response) {
    if (response.data == null || response.data is! Map) return;
    if (response.data['status'] == true) return;

    final dynamic errorKey = response.data['key'];
    final dynamic errorMessage = response.data['msg'];

    if (errorKey == null) return;

    final statusCode = _mapErrorKeyToStatusCode(errorKey.toString());

    if (statusCode != null) {
      throw DioException(
        type: DioExceptionType.badResponse,
        requestOptions: response.requestOptions,
        response: Response(
          requestOptions: response.requestOptions,
          data: {'message': errorMessage},
          statusCode: statusCode,
        ),
        error: {'message': errorMessage},
      );
    }
  }

  // bool isNeedApproval(String key) {
  //   if (key == 'needApproval') {
  //     UserCubit.instance.setUserStatus(UserStatus.needApproval);
  //   }
  //   UserCubit.instance.setUserStatus(UserStatus.needApproval);
  //   return false;
  // }

  int? _mapErrorKeyToStatusCode(String errorKey) {
    switch (errorKey) {
      case 'fail':
        return HttpStatus.badRequest;
      case 'unauthenticated':
        return HttpStatus.unauthorized;
      case 'blocked':
        return HttpStatus.locked;
      case 'exception':
        return HttpStatus.internalServerError;
      case 'needActive':
        return HttpStatus.forbidden;
      default:
        return null;
    }
  }
}
