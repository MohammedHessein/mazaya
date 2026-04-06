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

  /// 🔥 LOCAL UPDATE
  void toggleLocal(int id) {
    if (state.data.id == id) {
      updateData(state.data.copyWith(isFav: !state.data.isFav));
    }
  }
}
