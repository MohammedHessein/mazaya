import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/scaffolds/scaffold_header_content.dart';
import 'package:mazaya/src/core/widgets/scaffolds/scaffold_top_row.dart';

class SliverScaffoldBody extends StatelessWidget {
  final ScaffoldHeaderType headerType;
  final String? imageUrl;
  final String? userName;
  final bool showBackButton;
  final String title;
  final Widget? trailing;
  final Widget? headerWidget;
  final Widget? headLineWidget;
  final List<Widget> slivers;
  final bool extendBody;

  const SliverScaffoldBody({
    super.key,
    required this.headerType,
    this.imageUrl,
    this.userName,
    required this.showBackButton,
    required this.title,
    this.trailing,
    this.headerWidget,
    this.headLineWidget,
    required this.slivers,
    required this.extendBody,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 220.h,
                child: Image.asset(
                  AppAssets.svg.baseSvg.curveBackground.path,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    ScaffoldTopRow(
                      headerType: headerType,
                      imageUrl: imageUrl,
                      userName: userName,
                      showBackButton: showBackButton,
                      title: title,
                      trailing: trailing,
                    ),
                    ScaffoldHeaderContent(
                      headerType: headerType,
                      headerWidget: headerWidget,
                      headLineWidget: headLineWidget,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ...slivers,
        if (extendBody) SliverToBoxAdapter(child: 100.szH),
      ],
    );
  }
}
