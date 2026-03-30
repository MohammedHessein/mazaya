import 'package:flutter/material.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';

class ScaffoldHeaderContent extends StatelessWidget {
  final ScaffoldHeaderType headerType;
  final Widget? headerWidget;
  final Widget? headLineWidget;

  const ScaffoldHeaderContent({
    super.key,
    required this.headerType,
    this.headerWidget,
    this.headLineWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (headerType) {
      case ScaffoldHeaderType.profile:
        return SizedBox();
      case ScaffoldHeaderType.auth:
        return Column(
          children: [headerWidget ?? const SizedBox.shrink(), 50.szH],
        );
      case ScaffoldHeaderType.home:
        return Column(
          children: [headerWidget ?? const SizedBox.shrink(), 50.szH],
        );
      case ScaffoldHeaderType.standard:
        return Column(
          children: [
            if (headLineWidget != null) headLineWidget!,
            headerWidget ?? const SizedBox.shrink(),
            if (headerWidget != null) 24.szH else 80.szH,
          ],
        );
    }
  }
}
