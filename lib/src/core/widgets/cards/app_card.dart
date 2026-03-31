import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/image_widgets/cached_image.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final String? status;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const AppCard({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.status,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  width: 65.w,
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(AppCircular.r8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppCircular.r8),
                    child: (imageUrl != null && imageUrl!.isNotEmpty)
                        ? (imageUrl!.startsWith('http')
                              ? CachedImage(url: imageUrl!, fit: BoxFit.cover)
                              : (imageUrl!.endsWith('.svg')
                                    ? Padding(
                                        padding: EdgeInsets.all(8.w),
                                        child: SvgPicture.asset(
                                          imageUrl!,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : Image.asset(
                                        imageUrl!,
                                        fit: BoxFit.cover,
                                      )))
                        : Icon(Icons.image, color: AppColors.gray400),
                  ),
                ),
                if (onFavoriteTap != null)
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: 4.h,
                    end: 4.w,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: AppSize.sH30,
                        color: isFavorite ? AppColors.error : AppColors.white,
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
                          borderRadius: BorderRadius.circular(
                            AppCircular.r20,
                          ),
                        ),
                        child: Text(
                          status!,
                          style: context.textStyle.s10.bold.setPrimaryColor,
                        ),
                      ),
                    ),
                  Text(
                    title,
                    style: context.textStyle.s14.bold.setBlackColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
    );
  }
}
