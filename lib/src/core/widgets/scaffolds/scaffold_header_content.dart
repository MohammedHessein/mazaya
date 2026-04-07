import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';

class HeaderContent extends StatelessWidget {
  final HeaderConfig config;

  const HeaderContent({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    switch (config.type) {
      case ScaffoldHeaderType.profile:
        return config.headerWidget ?? const SizedBox();

      case ScaffoldHeaderType.home:
      case ScaffoldHeaderType.auth:
        return Column(
          children: [
            config.headerWidget ?? const SizedBox(),
            if (config.headerWidget != null) 30.verticalSpace,
          ],
        );

      case ScaffoldHeaderType.standard:
        return Column(
          children: [
            if (config.headLineWidget != null) config.headLineWidget!,
            config.headerWidget ?? const SizedBox(),
            const SizedBox(height: 24),
          ],
        );
    }
  }
}
