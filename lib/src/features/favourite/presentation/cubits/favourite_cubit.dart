part of '../imports/view_imports.dart';

@injectable
class FavouriteCubit extends PaginatedCubit<CouponEntity> {
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
          },
          {
            'id': '2',
            'title': 'ملابس زارا',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': true,
          },
        ],
        'pagination': {
          'total': 2,
          'count': 2,
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
