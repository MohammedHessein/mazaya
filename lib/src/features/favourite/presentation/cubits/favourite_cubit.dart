part of '../imports/view_imports.dart';

@injectable
class FavouriteCubit extends PaginatedCubit<CouponEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
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

  @override
  List<CouponEntity> parseItems(json) {
    if (json == null || json['data'] == null || json['data']['data'] == null) {
      return [];
    }
    return (json['data']['data'] as List).map((e) {
      final coupon = CouponEntity.fromJson(Map<String, dynamic>.from(e));
      return coupon.copyWith(isFav: true);
    }).toList();
  }

  @override
  PaginationMeta parsePagination(json) {
    if (json == null || json['data'] == null || json['data']['meta'] == null) {
      return const PaginationMeta(
          totalItems: 0,
          countItems: 0,
          perPage: 10,
          totalPages: 1,
          currentPage: 1);
    }
    return PaginationMeta.fromJson(json['data']['meta']);
  }

  void toggleFavorite(int id) async {
    final currentData = state.data;
    // Remove the item from the list if it's currently fav (unfavoriting)
    final updatedItems =
        currentData.items.where((coupon) => coupon.id != id).toList();

    setSuccess(data: currentData.copyWith(items: updatedItems));

    // Call API to sync with server
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
