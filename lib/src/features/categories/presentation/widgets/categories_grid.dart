import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/features/home/model/category_model.dart';
import 'package:mazaya/src/features/home/presentation/widgets/category_item.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppPadding.pW12,
      runSpacing: AppPadding.pW12,
      children: categories
          .map((category) => CategoryItem(category: category))
          .toList(),
    );
  }
}
