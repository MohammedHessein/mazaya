import 'package:injectable/injectable.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/error/failure.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class CouponsCubit extends PaginatedCubit<CouponEntity> {
  CouponsCubit() : super(itemMapper: CouponEntity.fromJson);

  CategoryEntity? _selectedCategory;
  CountryEntity? _selectedCountry;
  CityEntity? _selectedCity;
  RegionEntity? _selectedRegion;
  BaseIdAndNameEntity? _selectedLocation;
  String? _selectedSort;
  String? _selectedNearby;

  CategoryEntity? get selectedCategory => _selectedCategory;
  CountryEntity? get selectedCountry => _selectedCountry;
  CityEntity? get selectedCity => _selectedCity;
  RegionEntity? get selectedRegion => _selectedRegion;
  BaseIdAndNameEntity? get selectedLocation => _selectedLocation;
  String? get selectedSort => _selectedSort;
  String? get selectedNearby => _selectedNearby;

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
          if (_selectedCategory != null) 'category_id': _selectedCategory?.id,
          if (_selectedLocation != null) 'location_id': _selectedLocation?.id,
          if (_selectedSort != null) 'sort': _selectedSort,
          if (_selectedNearby != null && _selectedNearby != 'all')
            'near_by': _selectedNearby,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
        },
        mapper: (json) => json,
      ),
    );
  }

  void applyFilters({
    CategoryEntity? category,
    CountryEntity? country,
    CityEntity? city,
    RegionEntity? region,
    String? sort,
    String? nearby,
  }) {
    _selectedCategory = category;
    _selectedCountry = country;
    _selectedCity = city;
    _selectedRegion = region;
    _selectedLocation = region ?? city ?? country;
    _selectedSort = sort;
    _selectedNearby = nearby;
    fetchInitialData(key: filterKey);
  }

  void removeCategory() {
    _selectedCategory = null;
    fetchInitialData(key: filterKey);
  }

  void removeLocation() {
    _selectedLocation = null;
    _selectedCountry = null;
    _selectedCity = null;
    _selectedRegion = null;
    fetchInitialData(key: filterKey);
  }

  void removeSort() {
    _selectedSort = null;
    fetchInitialData(key: filterKey);
  }

  void removeNearby() {
    _selectedNearby = null;
    fetchInitialData(key: filterKey);
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedCountry = null;
    _selectedCity = null;
    _selectedRegion = null;
    _selectedLocation = null;
    _selectedSort = null;
    _selectedNearby = null;
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

  /// 🌐 API CALL
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
