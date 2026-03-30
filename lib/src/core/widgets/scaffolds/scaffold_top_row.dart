import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/widgets/universal_media/universal_media_widget.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/features/notifications/presentation/imports/view_imports.dart';

class ScaffoldTopRow extends StatelessWidget {
  final ScaffoldHeaderType headerType;
  final String? imageUrl;
  final String? userName;
  final bool showBackButton;
  final String title;
  final Widget? trailing;

  const ScaffoldTopRow({
    super.key,
    required this.headerType,
    this.imageUrl,
    this.userName,
    required this.showBackButton,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
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
                  radius: 27.r,
                  backgroundImage: imageUrl != null ? AssetImage(imageUrl!) : null,
                  backgroundColor: AppColors.gray100,
                  child: imageUrl == null
                      ? Icon(Icons.person, color: AppColors.primary)
                      : null,
                ),
                12.szW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.szH,
                    Text(
                      LocaleKeys.welcomeHome,
                      style: context.textStyle.s12.regular.setColor(
                        AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      userName ?? 'محمد حسين',
                      style: context.textStyle.s14.bold.setWhiteColor,
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () => Go.to(const NotificationScreen()),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 0.2),
                ),
                child: Badge(
                  alignment: AlignmentDirectional.topStart,
                  child: AppAssets.svg.baseSvg.notificationHome.svg(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (!showBackButton && trailing == null && title.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.pH20,
        horizontal: AppPadding.pW16,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (headerType == ScaffoldHeaderType.standard && title.isNotEmpty)
            Text(title, style: context.textStyle.s16.medium.setWhiteColor),
          Row(
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
        ],
      ),
    );
  }
}
