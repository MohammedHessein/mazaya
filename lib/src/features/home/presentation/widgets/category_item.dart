import 'package:flutter/material.dart';
import 'package:mazaya/src/features/coupons/presentation/view/view_imports.dart';

import '../../model/category_model.dart';
import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../main/presentation/view/main_screen.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../coupons/presentation/cubits/coupons_cubit.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('CategoryItem: onTap triggered for category ${category.id}');
        
        // 1. Set the category filter in CouponsCubit
        injector<CouponsCubit>().applyFilters(
          category: CategoryEntity(id: category.id, name: category.name),
        );

        // 2. Switch to Coupons tab (index 1) in MainScreen
        if (MainScreenState.instance != null) {
          debugPrint('CategoryItem: Switching to Coupons tab (index 1)');
          MainScreenState.instance!.params.updateNavValue(1);
        } else {
          debugPrint('CategoryItem: MainScreenState.instance is NULL!');
        }

        // 3. Close the categories screen if it's open
        if (Go.canPop) {
          debugPrint('CategoryItem: Popping categories screen');
          Go.back();
        }
      },
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
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
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray100.withValues(alpha: .5),
              ),
              child: ClipOval(
                child: CachedImage(
                  url: category.image,
                  fit: BoxFit.fill,
                  bgColor: AppColors.gray100.withValues(alpha: .5),
                ),
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
      ),
    );
  }
}
