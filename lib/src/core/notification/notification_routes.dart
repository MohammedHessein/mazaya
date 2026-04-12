part of 'notification_service.dart';

class NotificationRoutes {
  static void navigateByType(Map<String, dynamic> data) {
    log('========================================');
    log('NotificationRoutes: navigateByType called');
    log('Full notification data: $data');

    // 1. Handle numeric notification_type (1-6)
    final nestedData = data['data'];
    final int? code = _extractNotificationType(nestedData);

    if (code != null) {
      final type = NotificationType.fromCode(code);
      if (type != null) {
        log('🎯 Handling numeric notification type: ${type.name} ($code)');
        type.action.navigate(data: data);
        return;
      }
    }

    // 2. Handle explicit 'redirect' field
    final String? redirect = data['redirect']?.toString();
    if (redirect != null && redirect.isNotEmpty) {
      log('🔗 Handling redirect link: $redirect');
      _handleRedirect(redirect);
      return;
    }

    // 3. Fallback to legacy 'type' string logic
    final String typeKey = data['type']?.toString() ?? '';
    final legacyType = typeKey.toNotification;

    if (legacyType != null) {
      log('📜 Handling legacy notification type: ${legacyType.key}');
      legacyType.action.navigate(data: data);
    } else {
      log('⚠️ WARNING: Unknown notification type: $typeKey (Code: $code)');
    }
  }

  static void _handleRedirect(String redirect) {
    final parts = redirect.split('/');
    if (parts.length < 2) return;

    final String feature = parts[0];
    final String idStr = parts[1];
    final int? id = int.tryParse(idStr);

    if (id != null) {
      switch (feature) {
        case 'posts':
        case 'coupons':
          log('Navigating to CouponDetails with id: $id');
          Go.to(CouponDetailsScreen(id: id));
          break;
        case 'users':
          log('Navigating to User Profile with id: $id');
          break;
      }
    }
  }

  static int? _extractNotificationType(dynamic nestedData) {
    return _extractParam(nestedData, 'notification_type');
  }

  static int? _extractCategoryId(dynamic nestedData) {
    return _extractParam(nestedData, 'category_id');
  }

  static int? _extractParam(dynamic nestedData, String key) {
    if (nestedData == null) return null;
    if (nestedData is Map) {
      return int.tryParse(nestedData[key]?.toString() ?? '');
    }
    if (nestedData is String) {
      try {
        final Map<String, dynamic> parsed =
            Map<String, dynamic>.from(json.decode(nestedData));
        return int.tryParse(parsed[key]?.toString() ?? '');
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
