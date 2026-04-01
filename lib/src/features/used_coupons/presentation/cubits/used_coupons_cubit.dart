part of '../imports/view_imports.dart';

@injectable
class UsedCouponsCubit extends AsyncCubit<List<CouponEntity>> {
  UsedCouponsCubit() : super([]);

  Future<void> fetchUsedCoupons() async {
    await executeAsync(
      operation: () async {
        final result = await baseCrudUseCase.call<List<CouponEntity>>(
          CrudBaseParams<List<CouponEntity>>(
            api: ApiConstants.usedCoupons,
            httpRequestType: HttpRequestType.get,
            mapper: (json) {
              if (json == null || json['data'] == null) {
                return [];
              }
              return (json['data'] as List)
                  .map((e) => CouponEntity.fromJson(Map<String, dynamic>.from(e)))
                  .toList();
            },
          ),
        );
        return result;
      },
    );
  }

  Future<void> deleteCoupon(int id) async {
    // Optimistic UI update: Remove the item from the list immediately
    final currentList = List<CouponEntity>.from(state.data);
    final updatedList = currentList.where((coupon) => coupon.id != id).toList();
    updateData(updatedList);

    final result = await baseCrudUseCase.call(
      CrudBaseParams(
        api: "${ApiConstants.usedCoupons}/$id",
        httpRequestType: HttpRequestType.post,
        body: {'_method': 'DELETE'},
        mapper: (json) => json,
      ),
    );

    result.when(
      (success) {
        MessageUtils.showSnackBar(
          message: LocaleKeys.successMsg,
          baseStatus: BaseStatus.success,
        );
      },
      (failure) {
        // Rollback on failure
        updateData(currentList);
        MessageUtils.showSnackBar(
          message: failure.message,
          baseStatus: BaseStatus.error,
        );
      },
    );
  }

  void toggleFavorite(int id) async {
    final currentData = state.data;
    final updatedItems = currentData.map((coupon) {
      if (coupon.id == id) {
        return coupon.copyWith(isFav: !coupon.isFav);
      }
      return coupon;
    }).toList();

    updateData(updatedItems);

    await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.toggleFavorite,
        httpRequestType: HttpRequestType.post,
        body: {'product_id': id},
        mapper: (json) => json,
      ),
    );
  }
}
