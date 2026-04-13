import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

class StaticPageEntity {
  final String htmlContent;
  const StaticPageEntity({required this.htmlContent});

  factory StaticPageEntity.fromJson(Map<String, dynamic> json) {
    return StaticPageEntity(
      htmlContent: MappingHelpers.toStringSafe(json['content'] ?? json['body']),
    );
  }
}
