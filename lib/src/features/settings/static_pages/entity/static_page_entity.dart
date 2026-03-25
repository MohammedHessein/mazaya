import '../../../../config/res/config_imports.dart';

class StaticPageEntity {
  final String htmlContent;
  const StaticPageEntity({required this.htmlContent});

  factory StaticPageEntity.fromJson(Map<String, dynamic> json) {
    return StaticPageEntity(
      htmlContent: json['content'] as String? ?? ConstantManager.emptyText,
    );
  }
}
