part of 'notification_service.dart';

class NotificationRoutes {
  static void navigateByType(Map<String, dynamic> data) {
    log('========================================');
    log('NotificationRoutes: navigateByType called');
    log('Full notification data: $data');

    // 1. Handle notification_type from nested data
    final nestedData = data['data'];
    final int? notificationType = _extractNotificationType(nestedData);

    if (notificationType != null) {
      log('Handling notification_type: $notificationType');
      switch (notificationType) {
        case 1:
          // Account activation → Profile (More tab)
          log('Navigating to Profile (More tab)');
          Go.offAll(const MainScreen(initialTabIndex: 3));
          return;
        case 2:
        case 3:
          // Expiry reminders → Home
          log('Navigating to Home');
          Go.offAll(const MainScreen(initialTabIndex: 0));
          return;
        case 4:
          // Coupon used confirmation → Used Coupons
          log('Navigating to Used Coupons');
          Go.to(const UsedCouponsScreen());
          return;
        case 5:
          // Smart recommendation → Coupons (filtered by category)
          log('Navigating to Coupons tab');
          Go.offAll(const MainScreen(initialTabIndex: 1));
          return;
        case 6:
          // Dashboard / inactivity → Home
          log('Navigating to Home');
          Go.offAll(const MainScreen(initialTabIndex: 0));
          return;
      }
    }

    // 2. Handle explicit 'redirect' field if available
    final String? redirect = data['redirect']?.toString();
    if (redirect != null && redirect.isNotEmpty) {
      log('Handling redirect: $redirect');
      final parts = redirect.split('/');
      if (parts.length >= 2) {
        final String feature = parts[0];
        final String idStr = parts[1];
        final int? id = int.tryParse(idStr ?? '');

        if (id != null) {
          switch (feature) {
            case 'posts':
            case 'coupons':
              log('Navigating to CouponDetails with id: $id');
              Go.to(CouponDetailsScreen(id: id));
              return;
            case 'users':
              log('Navigating to User Profile with id: $id');
              return;
          }
        }
      }
    }

    // 3. Fallback to existing 'type' logic
    final String type = data['type']?.toString() ?? '';
    log('Fallback to notification type: $type');

    if (type == "text" && data['sender_id'] != null) {
      log('Navigating to chat with sender_id: ${data['sender_id']}');
      NotificationType.chat.action.navigate(data: data);
      return;
    }

    final notificationType2 = type.toNotification;
    if (notificationType2 != null) {
      log('Found notification type: ${notificationType2.key}');
      notificationType2.action.navigate(data: data);
    } else {
      log('WARNING: Unknown notification type: $type');
    }
  }

  static int? _extractNotificationType(dynamic nestedData) {
    if (nestedData == null) return null;
    if (nestedData is Map) {
      return int.tryParse(nestedData['notification_type']?.toString() ?? '');
    }
    if (nestedData is String) {
      try {
        final Map<String, dynamic> parsed =
            Map<String, dynamic>.from(json.decode(nestedData));
        return int.tryParse(parsed['notification_type']?.toString() ?? '');
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

