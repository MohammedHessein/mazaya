import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/app_text_field.dart';

class CouponsSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const CouponsSearchBar({super.key, this.onChanged, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r50),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTextField.withoutBorder(
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              hint: LocaleKeys.search,
              onChanged: (val) {
                if (onChanged != null) onChanged!(val ?? '');
              },
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: AppAssets.svg.baseSvg.search.svg(
                  width: AppSize.sW16,
                  height: AppSize.sH16,
                  colorFilter: ColorFilter.mode(
                    AppColors.gray400,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              hintStyle: context.textStyle.s14.regular.setColor(
                AppColors.gray400,
              ),
            ),
          ),
          // Filter Button
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              height: 62.h,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.pW16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(AppCircular.r50),
                  bottomEnd: Radius.circular(AppCircular.r50),
                ),
              ),
              child: AppAssets.svg.baseSvg.filter.svg(
                width: AppSize.sW20,
                height: AppSize.sH20,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
