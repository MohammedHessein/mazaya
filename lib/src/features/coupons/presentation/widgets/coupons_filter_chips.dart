import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';

class CouponsFilterChips extends StatelessWidget {
  const CouponsFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponsCubit, AsyncState<PaginatedData<CouponEntity>>>(
      builder: (context, state) {
        final cubit = context.read<CouponsCubit>();
        final category = cubit.selectedCategory;
        final region = cubit.selectedRegion;

        if (category == null && region == null) return const SizedBox.shrink();

        return SizedBox(
          height: 44.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
            children: [
              if (category != null)
                _buildChip(
                  context,
                  label: category.name,
                  onDelete: () => cubit.removeCategory(),
                ),
              if (category != null && region != null) 8.szW,
              if (region != null)
                _buildChip(
                  context,
                  label: region.name,
                  onDelete: () => cubit.removeRegion(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChip(BuildContext context,
      {required String label, required VoidCallback onDelete}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.cancel_outlined,
              size: 20.r,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: context.textStyle.s14.regular.setMainTextColor,
          ),
        ],
      ),
    );
  }
}
