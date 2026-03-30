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
            'id': '101',
            'title': 'كوبون كارفور مٌستخدم',
            'description': 'خصم 25% علي جميع المنتجات',
            'is_favorite': false,
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

  @override
  List<CouponEntity> parseItems(json) => (json['data'] as List)
      .map((e) => CouponEntity.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  @override
  PaginationMeta parsePagination(json) =>
      PaginationMeta.fromJson(json['pagination']);
}
