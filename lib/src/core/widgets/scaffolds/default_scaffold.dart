import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/text_style_extensions.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../../navigation/navigator.dart';
import '../universal_media/universal_media_widget.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final void Function()? onTap;
  final Widget? trailing;
  final Widget? headLineWidget;
  final bool showCurvedHeader;
  final Widget? headerWidget;
  final ScaffoldHeaderType headerType;
  final String? imageUrl;
  final String? userName;
  final String? subTitle;
  final bool showBackButton;

  const DefaultScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onTap,
    this.headLineWidget,
    this.trailing,
    this.showCurvedHeader = false,
    this.headerWidget,
    this.headerType = ScaffoldHeaderType.standard,
    this.imageUrl,
    this.userName,
    this.subTitle,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (onTap != null) onTap!();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppAssets.svg.baseSvg.curveBackground.path,
                fit: BoxFit.fill,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildTopRow(context),
                  _buildHeaderContent(context),
                  Expanded(child: body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    if (headerType == ScaffoldHeaderType.home) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW16,
          vertical: AppPadding.pH12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl!)
                      : null,
                  backgroundColor: AppColors.gray100,
                  child: imageUrl == null
                      ? Icon(Icons.person, color: AppColors.primary)
                      : null,
                ),
                12.szW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.welcomeBack,
                      style: context.textStyle.s12.regular.setColor(
                        AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      userName ?? LocaleKeys.username,
                      style: context.textStyle.s14.bold.setWhiteColor,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.white,
                size: 24.w,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.pH12,
        horizontal: AppPadding.pW16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton && context.isArabic)
            IconButton(
              onPressed: Go.back,
              icon: UniversalMediaWidget(
                path: AppAssets.svg.baseSvg.arrowRight.path,
                width: 30.w,
                height: 30.w,
              ),
            )
          else if (showBackButton && !context.isArabic)
            IconButton(
              onPressed: Go.back,
              icon: Icon(Icons.arrow_back_outlined, color: AppColors.white),
            )
          else
            const SizedBox.shrink(),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    switch (headerType) {
      case ScaffoldHeaderType.profile:
        return _buildProfileDecoration(context);
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
            if (headLineWidget != null)
              headLineWidget!
            else if (title.isNotEmpty)
              Text(title, style: context.textStyle.s16.medium.setWhiteColor),
            headerWidget ?? const SizedBox.shrink(),
            if (title.isNotEmpty || headerWidget != null) 30.szH else 80.szH,
          ],
        );
    }
  }

  Widget _buildProfileDecoration(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: AppCircular.r50,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            backgroundColor: AppColors.white,
            child: imageUrl == null
                ? Icon(
                    Icons.person,
                    size: AppCircular.r50,
                    color: AppColors.primary,
                  )
                : null,
          ),
          12.szH,
          Text(
            userName ?? 'أدم علي',
            style: context.textStyle.s18.bold.setMainTextColor,
          ),
          if (subTitle != null) ...[
            4.szH,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW12,
                vertical: AppPadding.pH4,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(AppCircular.r20),
              ),
              child: Text(
                subTitle!,
                style: context.textStyle.s12.regular.setColor(
                  AppColors.gray500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
