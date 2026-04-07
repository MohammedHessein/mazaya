import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/core/widgets/scaffolds/scaffold_header_content.dart';
import 'package:mazaya/src/core/widgets/scaffolds/scaffold_top_row.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';

class AppHeaderSliver extends StatelessWidget {
  final HeaderConfig config;

  const AppHeaderSliver({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final isProfile = config.type == ScaffoldHeaderType.profile;

    return SliverAppBar(
      expandedHeight: _getHeight(),
      pinned: false,
      elevation: 0,
      clipBehavior: isProfile ? Clip.none : Clip.hardEdge,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          clipBehavior: isProfile ? Clip.none : Clip.hardEdge,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                AppAssets.svg.baseSvg.curveBackground.path,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  ScaffoldTopRow(config: config),
                  HeaderContent(config: config),
                ],
              ),
            ),
            if (isProfile && config.overlayWidget != null)
              Positioned(
                bottom: -45.h,
                left: 0,
                right: 0,
                child: config.overlayWidget!,
              ),
          ],
        ),
      ),
    );
  }

  double _getHeight() {
    switch (config.type) {
      case ScaffoldHeaderType.home:
        return 130.h;
      case ScaffoldHeaderType.profile:
        return 130.h;
      case ScaffoldHeaderType.auth:
        return 100.h;
      case ScaffoldHeaderType.standard:
        return 100.h;
    }
  }
}
