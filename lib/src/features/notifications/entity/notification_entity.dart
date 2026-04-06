import 'package:mazaya/src/config/res/config_imports.dart';

class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String body;
  final String createdAt;
  final int read;
  final String? redirect;
  final Map<String, dynamic> data;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.read,
    this.redirect,
    required this.data,
  });

  factory NotificationEntity.initial() => const NotificationEntity(
        id: SkeltonizerManager.short,
        type: SkeltonizerManager.short,
        title: SkeltonizerManager.short,
        body: SkeltonizerManager.medium,
        createdAt: SkeltonizerManager.medium,
        read: 1,
        data: {},
      );

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    final nestedData = Map<String, dynamic>.from(json["data"] ?? {});
    return NotificationEntity(
      id: json["id"]?.toString() ?? '',
      type: json["type"]?.toString() ?? '',
      // Extract from nested 'data' object if available
      title: nestedData["title"]?.toString() ?? '',
      body: nestedData["text"]?.toString() ?? '',
      redirect: nestedData["redirect"]?.toString(),
      data: Map<String, dynamic>.from(nestedData["data"] ?? {}),
      createdAt: json["created_at"]?.toString() ?? '',
      // Map 'read_at' to 'read' (1 if read, 0 if unread)
      read: json["read_at"] != null ? 1 : 0,
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'type': type,
        'title': title,
        'body': body,
        'redirect': redirect,
        'data': data,
        'created_at': createdAt,
        'read': read,
      };
}
