part of '../imports/view_imports.dart';

@injectable
class UsedCouponsCubit extends PaginatedCubit<CouponEntity> {
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
            'id': 101,
            'title': 'كوبون كارفور مٌستخدم',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_fav': false,
            'status': 'مستخدم',
          },
        ],
        'pagination': {
          'total': 1,
          'count': 1,
          'per_page': 10,
          'current_page': 1,
          'total_pages': 1,
        },
      },
    });
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

    // Call API (Even if dummy, we call it to demonstrate consistency)
    await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.toggleFavorite,
        httpRequestType: HttpRequestType.post,
        body: {'product_id': id},
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<CouponEntity> parseItems(json) {
    if (json == null || json['data'] == null || json['data']['data'] == null) {
      return [];
    }
    return (json['data']['data'] as List)
        .map((e) => CouponEntity.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  PaginationMeta parsePagination(json) {
    if (json == null ||
        json['data'] == null ||
        json['data']['pagination'] == null) {
      return const PaginationMeta(
          totalItems: 0,
          countItems: 0,
          perPage: 10,
          totalPages: 1,
          currentPage: 1);
    }
    return PaginationMeta.fromJson(json['data']['pagination']);
  }
}
