import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

import '../../../../config/res/config_imports.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.pH8,
        horizontal: AppPadding.pW12,
      ),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCircular.r50),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.black,
            radius: AppCircular.r20,
            backgroundImage: AssetImage(AppAssets.svg.baseSvg.search.path),
          ),
          8.szW,
          Text('مطاعم', style: context.textStyle.regular.s14),
        ],
      ),
    );
  }
}
