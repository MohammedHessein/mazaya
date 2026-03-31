import 'package:flutter/widgets.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';

class HeaderConfig {
  final ScaffoldHeaderType type;
  final String title;
  final String? imageUrl;
  final String? userName;
  final bool showBackButton;
  final Widget? trailing;
  final Widget? headerWidget;
  final Widget? headLineWidget;
  final Widget? overlayWidget;

  const HeaderConfig({
    this.type = ScaffoldHeaderType.standard,
    this.title = '',
    this.imageUrl,
    this.userName,
    this.showBackButton = true,
    this.trailing,
    this.headerWidget,
    this.headLineWidget,
    this.overlayWidget,
  });
}
