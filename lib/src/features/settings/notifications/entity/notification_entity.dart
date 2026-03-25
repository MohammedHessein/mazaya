import '../../../../config/res/config_imports.dart';

class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String body;
  final String createdAt;
  final int read;
  final Map<String, dynamic> data;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.read,
    required this.data,
  });

  factory NotificationEntity.initail() => const NotificationEntity(
    id: SkeltonizerManager.short,
    type: SkeltonizerManager.short,
    title: SkeltonizerManager.short,
    body: SkeltonizerManager.medium,
    createdAt: SkeltonizerManager.medium,
    read: 1,
    data: {},
  );

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      NotificationEntity(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        body: json["body"],
        data: json["data"] ?? {},
        createdAt: json["created_at"],
        read: json["read"],
      );

  Map<String, dynamic> get toMap => {
    'id': id,
    'type': type,
    'title': title,
    'body': body,
    'data': data,
    'created_at': createdAt,
    'read': read,
  };
}
