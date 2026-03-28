import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/error/failure.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

@injectable
class CouponsCubit extends PaginatedCubit<CouponEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return Success({
      'data': {
        'data': [
          {
            'id': '1',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': true,
          },
          {
            'id': '2',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
          },
          {
            'id': '3',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
          },
          {
            'id': '4',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
          },
          {
            'id': '5',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
          },
          {
            'id': '6',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
          },
          {
            'id': '7',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
          },
        ],
        'pagination': {
          'total_items': 5,
          'count_items': 5,
          'per_page': 10,
          'current_page': 1,
          'total_pages': 1,
        },
      },
    });
  }

  @override
  List<CouponEntity> parseItems(json) => (json['data'] as List)
      .map((e) => CouponEntity.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  @override
  PaginationMeta parsePagination(json) =>
      PaginationMeta.fromJson(json['pagination']);

  void clearData() async {
    setSuccess(data: PaginatedData.initial());
  }

  void toggleFavorite(String id) {
    final currentData = state.data;
    final updatedItems = currentData.items.map((coupon) {
      if (coupon.id == id) {
        return coupon.copyWith(isFavorite: !coupon.isFavorite);
      }
      return coupon;
    }).toList();

    setSuccess(data: currentData.copyWith(items: updatedItems));
  }
}
