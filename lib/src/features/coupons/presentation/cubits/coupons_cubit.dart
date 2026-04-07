import 'package:injectable/injectable.dart';
import 'package:mazaya/src/config/res/config_imports.dart'; // Add this for ConstantManager
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/error/failure.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:multiple_result/multiple_result.dart'; // Add this for Result

@lazySingleton
class CouponsCubit extends PaginatedCubit<CouponEntity> {
  CouponsCubit() : super(itemMapper: CouponEntity.fromJson);

  CategoryEntity? _selectedCategory;
  RegionEntity? _selectedRegion;

  CategoryEntity? get selectedCategory => _selectedCategory;
  RegionEntity? get selectedRegion => _selectedRegion;

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? searchQuery,
  }) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.coupons,
        httpRequestType: HttpRequestType.get,
        queryParameters: {
          ...ConstantManager.paginateJson(page)!,
          if (_selectedCategory != null)
            'category_id': _selectedCategory?.id,
          if (_selectedRegion != null ||
              UserCubit.instance.state.userModel.locationId != null)
            'location_id':
                _selectedRegion?.id ??
                UserCubit.instance.state.userModel.locationId,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
        },
        mapper: (json) => json,
      ),
    );
  }

  void applyFilters({
    CategoryEntity? category,
    RegionEntity? region,
  }) {
    _selectedCategory = category;
    _selectedRegion = region;
    fetchInitialData(key: filterKey);
  }

  void removeCategory() {
    _selectedCategory = null;
    fetchInitialData(key: filterKey);
  }

  void removeRegion() {
    _selectedRegion = null;
    fetchInitialData(key: filterKey);
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedRegion = null;
    fetchInitialData(key: filterKey);
  }

  void clearData() async {
    setSuccess(data: PaginatedData.initial());
  }

  /// 🔥 LOCAL UPDATE
  void toggleLocal(int id) {
    final currentData = state.data;
    final updatedItems = currentData.items.map((coupon) {
      if (coupon.id == id) {
        return coupon.copyWith(isFav: !coupon.isFav);
      }
      return coupon;
    }).toList();

    setSuccess(data: currentData.copyWith(items: updatedItems));
  }

  /// 🌐 API CALL (Renamed for clarity in FavoriteManager)
  Future<Result<String, Failure>> toggleRemote(int id) async {
    final result = await baseCrudUseCase.call<String>(
      CrudBaseParams(
        api: ApiConstants.toggleFavorite,
        httpRequestType: HttpRequestType.post,
        body: {'product_id': id},
        mapper: (json) => json['message']?.toString() ?? '',
      ),
    );
    return result;
  }
}
