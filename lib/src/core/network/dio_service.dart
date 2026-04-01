import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/language/languages.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/error/exceptions.dart';
import 'package:mazaya/src/core/helpers/cache_service.dart';
import 'package:mazaya/src/core/shared/models/base_model.dart';
import 'api_endpoints.dart';
import 'backend_configuation.dart';
import 'configuration_interceptor.dart';
import 'extensions.dart';
import 'network_request.dart';
import 'network_service.dart';
import 'un_authenticated_interceptor.dart';

@LazySingleton(as: NetworkService)
class DioService implements NetworkService {
  late final Dio _dio;

  DioService() {
    _dio = Dio()
      ..options.connectTimeout = const Duration(
        milliseconds: ConstantManager.connectTimeoutDuration,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: ConstantManager.recieveTimeoutDuration,
      )
      ..options.responseType = ResponseType.json;

    if (BackendConfiguation.type.isPhp) {
      _dio.interceptors.add(ConfigurationInterceptor());
    }

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 100,
        ),
      );
      _dio.interceptors.add(UnAuthenticatedInterceptor.instance);
    }
  }

  Future<String> getBaseUrl() async {
    return await SecureStorage.read(SecureLocalVariableKeys.baseUrlKey) ?? '';
  }

  @override
  Future<void> updateBaseUrl() async {
    final baseUrl = await getBaseUrl();
    _dio.options.baseUrl = baseUrl.isNotEmpty ? baseUrl : ApiConstants.baseUrl;
  }

  @override
  void setToken(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${token.replaceAll('Bearer', '').trim()}';
    changeLocale();
  }

  @override
  void removeToken() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  void changeLocale({String? locale}) {
    final langCode = locale ?? Languages.currentLanguage.languageCode;
    _dio.options.headers[HttpHeaders.acceptLanguageHeader] = langCode;
    _dio.options.headers['lang'] = langCode;
  }

  Future<Map<String, dynamic>> publicHeaders() async {
    return {"lang": Languages.currentLanguage.languageCode};
  }

  @override
  Future<BaseModel<Model>> callApi<Model>(
    NetworkRequest networkRequest, {
    Model Function(dynamic json)? mapper,
  }) async {
    try {
      final publicHeadersValue = await publicHeaders();
      await networkRequest.prepareRequestData();
      final response = await _dio.request(
        networkRequest.path,
        data: networkRequest.hasBodyAndProgress()
            ? networkRequest.isFormData
                  ? FormData.fromMap(networkRequest.body!)
                  : networkRequest.body
            : networkRequest.body,
        queryParameters: networkRequest.queryParameters,
        onSendProgress: networkRequest.hasBodyAndProgress()
            ? networkRequest.onSendProgress
            : null,
        onReceiveProgress: networkRequest.hasBodyAndProgress()
            ? networkRequest.onReceiveProgress
            : null,
        options: Options(
          method: networkRequest.asString(),
          headers: networkRequest.headers != null
              ? {...networkRequest.headers!, ...publicHeadersValue}
              : publicHeadersValue,
        ),
      );
      if (mapper != null) {
        return BaseModel.fromJson(response.data, jsonToModel: mapper);
      } else {
        return BaseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint("Network Error: $e");
        debugPrint(s.toString());
      }
      throw ServerException(LocaleKeys.exceptionError);
    }
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NoInternetConnectionException(LocaleKeys.checkInternet);
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case HttpStatus.badRequest:
            throw BadRequestException(
              error.response?.data['message'] ?? LocaleKeys.badRequest,
            );
          case HttpStatus.unauthorized:
            throw UnauthorizedException(
              error.response?.data['message'] ?? LocaleKeys.badRequest,
            );
          case HttpStatus.locked:
            throw BlockedException(
              error.response?.data['message'] ?? LocaleKeys.badRequest,
            );
          case HttpStatus.forbidden:
            throw NeedActiveException(
              error.response?.data['message'] ?? LocaleKeys.badRequest,
            );
          case HttpStatus.notFound:
            throw NotFoundException(LocaleKeys.notFound);
          case HttpStatus.conflict:
            throw ConflictException(
              error.response?.data['message'] ?? LocaleKeys.serverError,
            );
          case HttpStatus.internalServerError:
            throw InternalServerErrorException(
              error.response?.data['message'] ?? LocaleKeys.serverError,
            );
          default:
            throw ServerException(LocaleKeys.serverError);
        }
      case DioExceptionType.cancel:
        throw ServerException(LocaleKeys.intenetWeakness);
      case DioExceptionType.unknown:
        throw ServerException(
          error.response?.data['message'] ?? LocaleKeys.exceptionError,
        );
      default:
        throw ServerException(
          error.response?.data['message'] ?? LocaleKeys.exceptionError,
        );
    }
  }
}
