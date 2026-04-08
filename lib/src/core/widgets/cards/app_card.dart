import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/core/widgets/universal_media/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final String? status;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final String? packageName;
  final bool isDisabled;

  const AppCard({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.status,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.packageName,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Container(
          margin: EdgeInsets.only(bottom: AppPadding.pH12),
          padding: EdgeInsets.all(AppPadding.pW12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 110.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(AppCircular.r8),
                    ),
                    child: CachedImage(
                      url: imageUrl ?? '',
                      fit: BoxFit.fill,
                      width: 110.w,
                      height: 110.h,
                      bgColor: AppColors.gray100,
                      borderRadius: BorderRadius.circular(AppCircular.r8),
                    ),
                  ),
                  if (onFavoriteTap != null)
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      top: 6.h,
                      end: 6.w,
                      child: GestureDetector(
                        onTap: onFavoriteTap,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 20.h,
                            color: isFavorite ? AppColors.error : AppColors.gray400,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              12.szW,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.szH,
                    if (status != null)
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppCircular.r20),
                          ),
                          child: Text(
                            status!,
                            style: context.textStyle.s10.bold.setPrimaryColor,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: context.textStyle.s14.bold.setBlackColor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (packageName != null) ...[
                          8.szW,
                          () {
                            final mType = MembershipType.fromString(packageName);
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.pW12,
                                vertical: AppPadding.pH4,
                              ),
                              decoration: BoxDecoration(
                                color: mType.backgroundColor(context),
                                borderRadius:
                                    BorderRadius.circular(AppCircular.r20),
                              ),
                              child: Text(
                                mType.shortLabel,
                                style: context.textStyle.s10.bold.setColor(
                                  mType.textColor(context),
                                ),
                              ),
                            );
                          }(),
                        ],
                      ],
                    ),
                    4.szH,
                    if (description.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          description,
                          style: context.textStyle.s14.regular.setColor(
                            AppColors.gray400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
