import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/features/home/presentation/widgets/category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.sections,
                style: context.textStyle.s16.bold.setBlackColor,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  LocaleKeys.showMore,
                  style: context.textStyle.s14.regular.setHintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (context, index) => 12.szW,
            itemBuilder: (context, index) {
              return CategoryItem();
            },
          ),
        ),
      ],
    );
  }
}
