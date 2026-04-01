import 'package:flutter/material.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';
import '../widgets/coupon_details_content.dart';

class CouponDetailsBody extends StatelessWidget {
  const CouponDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AsyncBlocBuilder<CouponDetailsCubit, CouponEntity>(
        skeletonBuilder: (context) => CouponDetailsContent(
          coupon: const CouponEntity.empty(),
          isSkeleton: true,
        ),
        builder: (context, data) => CouponDetailsContent(coupon: data),
      ),
    );
  }
}
