import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

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
    final nestedData = json["data"] is Map ? Map<String, dynamic>.from(json["data"]) : <String, dynamic>{};
    return NotificationEntity(
      id: MappingHelpers.toStringSafe(json["id"]),
      type: MappingHelpers.toStringSafe(json["type"]),
      // Extract from nested 'data' object if available
      title: MappingHelpers.toStringSafe(nestedData["title"]),
      body: MappingHelpers.toStringSafe(nestedData["text"]),
      redirect: nestedData["redirect"] != null ? MappingHelpers.toStringSafe(nestedData["redirect"]) : null,
      data: nestedData["data"] is Map ? Map<String, dynamic>.from(nestedData["data"]) : <String, dynamic>{},
      createdAt: MappingHelpers.toStringSafe(json["created_at"]),
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
