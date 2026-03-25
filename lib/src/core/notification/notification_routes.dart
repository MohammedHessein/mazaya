part of 'notification_service.dart';

class NotificationRoutes {
  static void navigateByType(Map<String, dynamic> data) {
    log('========================================');
    log('NotificationRoutes: navigateByType called');
    log('Full notification data: $data');
    log('Data keys: ${data.keys.toList()}');
    log('Data values: ${data.values.toList()}');

    final String type = data['type'].toString();
    log('Notification type: $type');

    // Log all possible body/message fields
    log('data[body]: ${data['body']}');
    log('data[message]: ${data['message']}');
    log('data[content]: ${data['content']}');
    log('data[text]: ${data['text']}');
    log('data[title]: ${data['title']}');
    log('========================================');

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


