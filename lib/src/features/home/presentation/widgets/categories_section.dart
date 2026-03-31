import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';

import '../../model/category_model.dart';
import '../../model/home_model.dart';
import '../cubits/home_cubit.dart';
import '../../../../core/navigation/navigator.dart';
import 'category_item.dart';
import 'package:mazaya/src/features/categories/presentation/view/categories_screen.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.categories,
                style: context.textStyle.s16.bold.setBlackColor,
              ),
              TextButton(
                onPressed: () => Go.to(const CategoriesScreen()),
                child: Text(
                  LocaleKeys.showMore,
                  style: context.textStyle.s14.regular.setHintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80.h,
          child: AsyncBlocBuilder<HomeCubit, HomeModel?>(
            skeletonBuilder: (context) => ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => const CategoryItem(
                category: CategoryModel(id: 0, name: 'Loading', image: ''),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: AppPadding.pW12),
            ),
            builder: (context, home) {
              final categories = home?.categories ?? [];
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) =>
                    CategoryItem(category: categories[index]),
                separatorBuilder: (context, index) =>
                    SizedBox(width: AppPadding.pW12),
              );
            },
          ),
        ),
      ],
    );
  }
}
