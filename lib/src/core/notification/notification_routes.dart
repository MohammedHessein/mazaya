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
      _handleRedirect(redirect, data);
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

  static void _handleRedirect(String redirect, Map<String, dynamic> data) {
    String feature = redirect;
    int? id;

    // Handle feature/id format (e.g., "coupons/123")
    if (redirect.contains('/')) {
      final parts = redirect.split('/');
      feature = parts[0];
      id = int.tryParse(parts[1]);
    }

    // Fallback: extract ID from the data map if not in the string
    if (id == null) {
      if (feature == 'coupons' || feature == 'coupon_details') {
        id = _extractCouponId(data['data'], data);
      } else if (feature == 'categories' || feature == 'category_details') {
        id = _extractCategoryId(data['data'], data);
      }
    }

    if (id != null) {
      log('🎯 Executing redirect to $feature with id: $id');
      switch (feature) {
        case 'posts':
        case 'coupons':
        case 'coupon_details':
          Go.to(CouponDetailsScreen(id: id));
          break;
        case 'categories':
        case 'category_details':
          // Attempt to resolve name for the chip
          String resolvedName = '';
          final homeState = injector<HomeCubit>().state;
          if (homeState.isSuccess) {
            final category = homeState.data?.categories.firstWhereOrNull(
              (c) => c.id == id,
            );
            if (category != null) resolvedName = category.name;
          }

          injector<CouponsCubit>().applyFilters(
            category: CategoryEntity(id: id, name: resolvedName),
          );
          Go.offAll(const MainScreen(initialTabIndex: 1));
          break;
      }
    } else {
      log('⚠️ Could not resolve ID for redirect feature: $feature');
      // Fallback to home or specific tab if known
      if (feature == 'coupons' || feature == 'coupon_details') {
        Go.offAll(const MainScreen(initialTabIndex: 1));
      } else {
        Go.offAll(const MainScreen(initialTabIndex: 0));
      }
    }
  }

  static int? _extractNotificationType(dynamic nestedData) {
    return _extractParam(nestedData, 'notification_type');
  }

  static int? _extractCategoryId(dynamic nestedData, [Map<String, dynamic>? fullData]) {
    final possibleKeys = ['category_id', 'categoryId', 'cat_id', 'id'];
    int? id;

    log('🔍 Searching for category ID in:');
    if (nestedData is Map) log('   - Nested Data Keys: ${nestedData.keys.toList()}');
    if (fullData != null) log('   - Full Data Keys: ${fullData.keys.toList()}');

    // 1. Check nested data first
    for (final key in possibleKeys) {
      id = _extractParam(nestedData, key);
      if (id != null) {
        log('✅ Found category ID in nested data with key: $key -> $id');
        return id;
      }
    }

    // 2. Check full data
    if (fullData != null) {
      for (final key in possibleKeys) {
        id = _extractParam(fullData, key);
        if (id != null) {
          log('✅ Found category ID in full data with key: $key -> $id');
          return id;
        }
      }
    }

    log('❌ Could not find category ID in any field using keys: $possibleKeys');
    return id;
  }

  static int? _extractCouponId(dynamic nestedData, [Map<String, dynamic>? fullData]) {
    final possibleKeys = ['coupon_id', 'couponId', 'id'];
    int? id;

    for (final key in possibleKeys) {
      id = _extractParam(nestedData, key);
      if (id != null) return id;
    }

    if (fullData != null) {
      for (final key in possibleKeys) {
        id = _extractParam(fullData, key);
        if (id != null) return id;
      }
    }

    return id;
  }

  static int? _extractParam(dynamic data, String key) {
    if (data == null) return null;

    // Helper for case-insensitive map lookup
    int? getFromMap(Map map, String k) {
      final String lowerK = k.toLowerCase();
      // Try exact, then lowercase/uppercase variations
      dynamic val = map[k] ?? map[lowerK] ?? map[k.toUpperCase()];

      // Try searching keys manually if still null
      if (val == null) {
        for (final mKey in map.keys) {
          if (mKey.toString().toLowerCase() == lowerK) {
            val = map[mKey];
            break;
          }
        }
      }

      if (val == null) return null;
      if (val is int) return val;
      return int.tryParse(val.toString());
    }

    if (data is Map) {
      return getFromMap(data, key);
    }

    if (data is String) {
      try {
        final dynamic decoded = json.decode(data);
        if (decoded is Map) {
          return getFromMap(decoded, key);
        }
      } catch (_) {
        // Not a JSON string
      }
    }

    return null;
  }
}
