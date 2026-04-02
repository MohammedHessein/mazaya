import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';

@injectable
class CouponDetailsCubit extends AsyncCubit<CouponEntity> {
  CouponDetailsCubit() : super(const CouponEntity.empty());

  Future<void> getCouponDetails(String id) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call<CouponEntity>(
        CrudBaseParams(
          api: ApiConstants.singleCoupon + id.toString(),
          httpRequestType: HttpRequestType.get,
          mapper: (json) => CouponEntity.fromJson(json['data']),
        ),
      ),
    );
  }

  void setInitialData(CouponEntity coupon) {
    updateData(coupon);
  }

  void toggleFavorite(int id) async {
    final currentData = state.data;
    final updatedData = currentData.copyWith(isFav: !currentData.isFav);
    updateData(updatedData);

    // Call API
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
