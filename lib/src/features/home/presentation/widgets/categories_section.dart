import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import 'package:mazaya/src/features/categories/presentation/view/categories_screen.dart';

import '../../../../core/navigation/navigator.dart';
import '../../model/category_model.dart';
import '../../model/home_model.dart';
import '../cubits/home_cubit.dart';
import 'category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<HomeCubit, HomeModel?>(
      skeletonBuilder: (context) =>
          const CategoriesSectionContent(isSkeleton: true),
      builder: (context, data) {
        final categories = data?.categories ?? [];
        if (categories.isEmpty) return const SizedBox.shrink();
        return CategoriesSectionContent(categories: categories);
      },
    );
  }
}

class CategoriesSectionContent extends StatelessWidget {
  final List<CategoryModel> categories;
  final bool isSkeleton;

  const CategoriesSectionContent({
    super.key,
    this.categories = const [],
    this.isSkeleton = false,
  });

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
              if (!isSkeleton)
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
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
            scrollDirection: Axis.horizontal,
            itemCount: isSkeleton ? 5 : categories.length,
            itemBuilder: (context, index) => isSkeleton
                ? const CategoryItem(
                    category: CategoryModel(id: 0, name: 'Loading', image: ''),
                  )
                : CategoryItem(category: categories[index]),
            separatorBuilder: (context, index) =>
                SizedBox(width: AppPadding.pW12),
          ),
        ),
        20.szH,
      ],
    );
  }
}
