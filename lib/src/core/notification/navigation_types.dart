part of 'notification_service.dart';

enum NotificationType {
  // Admin Notifications
  adminNotify("admin_notify", NoAction()),
  adminUserBlocked("admin_user_blocked", NoAction()),
  // User Status
  block("block", NoAction()),
  blockNotify("block_notify", NoAction()),
  deleteNotify("delete_notify", NoAction()),
  userBlocked("user_blocked", NoAction()),

  // Chat
  chat("new_message", ChatScreenAction());

  final String key;
  final NotificationNavigation action;

  const NotificationType(this.key, this.action);
}

extension NotificationTypeExtension on String {
  NotificationType? get toNotification => NotificationType.values
      .where((element) => element.key == this)
      .firstOrNull;
}

abstract interface class NotificationNavigation {
  const NotificationNavigation();

  void navigate({required Map<String, dynamic> data});
}

class NoAction implements NotificationNavigation {
  const NoAction();

  @override
  void navigate({required Map<String, dynamic> data}) {
    return;
  }
}

class ChatScreenAction implements NotificationNavigation {
  const ChatScreenAction();

  @override
  void navigate({required Map<String, dynamic> data}) {
    // Extract chat details from notification data
    final receiverId =
        num.tryParse(data["receiver_id"]?.toString() ?? "")?.toInt() ?? 0;
    // final roomId = num.tryParse(data["room_id"]?.toString() ?? "")?.toInt();
    // final receiverName = data["sender_name"]?.toString() ?? '';
    // final receiverImage = data["avatar"]?.toString() ?? '';

    if (receiverId > 0) {
      // Go.to(
      //   ChatDetailsScreen(
      //     receiverId: receiverId,
      //     receiverName: receiverName,
      //     receiverImage: receiverImage,
      //     roomId: roomId,
      //   ),
      // );
    }
  }
}
