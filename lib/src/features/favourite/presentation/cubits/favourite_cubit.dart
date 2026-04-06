part of '../imports/view_imports.dart';

@injectable
class FavouriteCubit extends PaginatedCubit<CouponEntity> {
  FavouriteCubit()
    : super(
        itemMapper: (json) => CouponEntity.fromJson(
          Map<String, dynamic>.from(json),
        ).copyWith(isFav: true),
      );

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? searchQuery,
  }) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.favorites,
        httpRequestType: HttpRequestType.get,
        queryParameters: ConstantManager.paginateJson(page),
        mapper: (json) => json,
      ),
    );
  }

  /// 🔥 LOCAL UPDATE (add/remove)
  void toggleLocal(int id, {CouponEntity? coupon}) {
    final currentData = state.data;
    final currentItems = currentData.items;

    final exists = currentItems.any((e) => e.id == id);

    if (exists) {
      final updated = currentItems.where((e) => e.id != id).toList();
      setSuccess(data: currentData.copyWith(items: updated));
    } else if (coupon != null) {
      final updated = [
        coupon.copyWith(isFav: true),
        ...currentItems,
      ];
      setSuccess(data: currentData.copyWith(items: updated));
    }
  }
}
