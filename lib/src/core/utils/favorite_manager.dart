import 'package:injectable/injectable.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/favourite/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/used_coupons/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/home/presentation/cubits/home_cubit.dart';
import 'package:mazaya/src/core/widgets/custom_messages.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';

@lazySingleton
class FavoriteManager {
  final CouponsCubit couponsCubit;
  final FavouriteCubit favouriteCubit;
  final UsedCouponsCubit usedCouponsCubit;
  final HomeCubit homeCubit;

  FavoriteManager(
    this.couponsCubit,
    this.favouriteCubit,
    this.usedCouponsCubit,
    this.homeCubit,
  );

  /// The main entry point for toggling favorites from the UI.
  /// [id] - The ID of the coupon being toggled.
  /// [coupon] - The coupon entity (optional, used to add to favorites list if not already there).
  void toggle({
    required int id,
    CouponEntity? coupon,
  }) {
    // 1. Perform immediate local updates (Optimistic UI)
    couponsCubit.toggleLocal(id);
    favouriteCubit.toggleLocal(id, coupon: coupon);
    usedCouponsCubit.toggleLocal(id);
    homeCubit.toggleLocal(id);

    // 2. Perform the remote API sync
    _toggleRemote(id);
  }

  Future<void> _toggleRemote(int id) async {
    // 1. Remote API call
    final result = await couponsCubit.toggleRemote(id);

    // 2. Handle feedback (Show message from API)
    result.when(
      (message) {
        MessageUtils.showSnackBar(
          message: message,
          baseStatus: BaseStatus.success,
        );
      },
      (failure) {
        // Rollback local update on failure
        couponsCubit.toggleLocal(id);
        favouriteCubit.toggleLocal(id, coupon: null);
        usedCouponsCubit.toggleLocal(id);
        homeCubit.toggleLocal(id);

        MessageUtils.showSnackBar(
          message: failure.message,
          baseStatus: BaseStatus.error,
        );
      },
    );
  }
}
