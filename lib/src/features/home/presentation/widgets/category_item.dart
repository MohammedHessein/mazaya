import 'package:flutter/material.dart';
import 'package:mazaya/src/features/coupons/presentation/view/view_imports.dart';

import '../../model/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 120.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: CachedImage(url: category.image, fit: BoxFit.cover),
            ),
          ),
          8.szW,
          Flexible(
            child: Text(
              category.name.isEmpty ? '---' : category.name,
              style: context.textStyle.s12.medium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
