import 'package:mazaya/src/config/res/config_imports.dart';

class CouponEntity {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String? status;
  final bool isFavorite;

  const CouponEntity({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.status,
    this.isFavorite = false,
  });

  factory CouponEntity.initial() => const CouponEntity(
        id: SkeltonizerManager.short,
        title: SkeltonizerManager.short,
        description: SkeltonizerManager.medium,
        isFavorite: false,
      );

  factory CouponEntity.fromJson(Map<String, dynamic> json) => CouponEntity(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        status: json["status"],
        isFavorite: json["is_favorite"] ?? false,
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'status': status,
        'is_favorite': isFavorite,
      };

  CouponEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? status,
    bool? isFavorite,
  }) =>
      CouponEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        status: status ?? this.status,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
