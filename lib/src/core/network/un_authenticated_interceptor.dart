import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_endpoints.dart';

/// true  -> blocked
/// false -> unauthenticated (session expired)
typedef UnAuthenticatedCallBackType = void Function(bool isBlocked);

class UnAuthenticatedInterceptor extends Interceptor {
  UnAuthenticatedInterceptor._();

  static UnAuthenticatedInterceptor? _instance;

  static UnAuthenticatedInterceptor get instance =>
      _instance ??= UnAuthenticatedInterceptor._();

  static const _blockedKeys = {
    "block",
    "admin_user_blocked",
    "block_notify",
    "delete_notify",
    "user_blocked",
  };

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data is String
        ? json.decode(response.data)
        : response.data;

    final bool isUnauthenticated =
        (response.statusCode == 401 &&
            !response.requestOptions.path.contains(ApiConstants.login)) ||
        (response.statusCode == 200 && data is Map && data['key'] == "unauthenticated");

    final bool isLoginPath =
        response.requestOptions.path.contains(ApiConstants.login);

    final bool isBlocked = !isLoginPath &&
        ((response.statusCode == 200 && data is Map && _blockedKeys.contains(data['key'])) ||
        (response.statusCode == 403));

    if (isUnauthenticated || isBlocked) {
      notifyListeners(isBlocked);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final data = err.response?.data;
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(ApiConstants.login)) {
      notifyListeners(false); // unauthenticated
    } else if (!err.requestOptions.path.contains(ApiConstants.login) &&
        (err.response?.statusCode == 403 ||
        (data is Map &&
            (data['exception']?.toString().contains('TokenBlacklistedException') ==
                    true ||
                data['message']
                        ?.toString()
                        .toLowerCase()
                        .contains('blacklisted') ==
                    true)))) {
      notifyListeners(true); // isBlocked
    }
    super.onError(err, handler);
  }

  final ObserverList<UnAuthenticatedCallBackType> _listeners =
      ObserverList<UnAuthenticatedCallBackType>();

  void addListener(UnAuthenticatedCallBackType listener) {
    _listeners.add(listener);
  }

  void removeListener(UnAuthenticatedCallBackType listener) {
    _listeners.remove(listener);
  }

  void notifyListeners(bool isBlocked) {
    if (_listeners.isEmpty) return;

    final localListeners = List<UnAuthenticatedCallBackType>.from(_listeners);
    for (var listener in localListeners) {
      if (_listeners.contains(listener)) {
        listener(isBlocked);
      }
    }
  }

  void dispose() {
    _listeners.clear();
  }
}
