part of 'notification_service.dart';

class NotificationRoutes {
  static void navigateByType(Map<String, dynamic> data) {
    log('========================================');
    log('NotificationRoutes: navigateByType called');
    log('Full notification data: $data');

    // 1. Handle explicit 'redirect' field if available
    final String? redirect = data['redirect']?.toString();
    if (redirect != null && redirect.isNotEmpty) {
      log('Handling redirect: $redirect');
      final parts = redirect.split('/');
      if (parts.length >= 2) {
        final String feature = parts[0];
        final String? idStr = parts[1];
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
              // Replace with your User/Profile screen navigation
              // Go.to(ProfileScreen(userId: id));
              return;
          }
        }
      }
    }

    // 2. Fallback to existing 'type' logic
    final String type = data['type']?.toString() ?? '';
    log('Fallback to notification type: $type');

    if (type == "text" && data['sender_id'] != null) {
      log('Navigating to chat with sender_id: ${data['sender_id']}');
      NotificationType.chat.action.navigate(data: data);
      return;
    }

    final notificationType = type.toNotification;
    if (notificationType != null) {
      log('Found notification type: ${notificationType.key}');
      notificationType.action.navigate(data: data);
    } else {
      log('WARNING: Unknown notification type: $type');
    }
  }
}
