import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart'; // Add this for Result
import 'package:mazaya/src/core/error/failure.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/config/res/config_imports.dart'; // Add this for ConstantManager

@injectable
class CouponsCubit extends PaginatedCubit<CouponEntity> {
  int? _categoryId;
  int? _locationId;

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.coupons,
        httpRequestType: HttpRequestType.get,
        queryParameters: {
          ...ConstantManager.paginateJson(page)!,
          if (_categoryId != null) 'category_id': _categoryId,
          if (_locationId != null) 'location_id': _locationId,
          if (key != null && key.isNotEmpty) 'name': key,
        },
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<CouponEntity> parseItems(json) {
    if (json == null || json['data'] == null || json['data']['data'] == null) return [];
    return (json['data']['data'] as List).map((e) => CouponEntity.fromJson(e)).toList();
  }

  @override
  PaginationMeta parsePagination(json) {
    if (json == null || json['data'] == null || json['data']['meta'] == null) return const PaginationMeta(totalItems: 0, countItems: 0, perPage: 30, totalPages: 1, currentPage: 1);
    return PaginationMeta.fromJson(json['data']['meta']);
  }

  void applyFilters({int? categoryId, int? locationId}) {
    _categoryId = categoryId;
    _locationId = locationId;
    fetchInitialData(key: filterKey);
  }

  void clearData() async {
    setSuccess(data: PaginatedData.initial());
  }

  void toggleFavorite(int id) async {
    final currentData = state.data;
    final updatedItems = currentData.items.map((coupon) {
      if (coupon.id == id) {
        return coupon.copyWith(isFav: !coupon.isFav);
      }
      return coupon;
    }).toList();

    setSuccess(data: currentData.copyWith(items: updatedItems));

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
