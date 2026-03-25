import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
        response.statusCode == 401 ||
        (response.statusCode == 200 && data['key'] == "unauthenticated");

    final bool isBlocked =
        response.statusCode == 200 && _blockedKeys.contains(data['key']);

    if (isUnauthenticated || isBlocked) {
      notifyListeners(isBlocked);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      notifyListeners(false); // unauthenticated
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
