part of '../imports/view_imports.dart';

@injectable
class NotificationsCubit extends PaginatedCubit<NotificationEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) async {
    // return await baseCrudUseCase.call(
    //   CrudBaseParams(
    //     api: ApiConstants.notifications,
    //     httpRequestType: HttpRequestType.get,
    //     queryParameters: ConstantManager.paginateJson(page),
    //     mapper: (json) => json,
    //   ),
    // );
    return Success({
      'data': {
        'data': [
          {
            'id': '1',
            'type': 'order',
            'title': 'تم استلام طلبك بنجاح',
            'body':
                'لقد تم استلام طلبك رقم #12345 بنجاح، جاري معالجة الطلب وسنخبرك بكل جديد.',
            'created_at': '10:00 ص',
            'read': 0,
            'data': {},
          },
          {
            'id': '2',
            'type': 'discount',
            'title': 'كوبون خصم جديد 20%',
            'body':
                'استمتع بخصم 20% على جميع المنتجات باستخدام الكود MAZAYA20. العرض متاح لفترة محدودة.',
            'created_at': '09:30 ص',
            'read': 1,
            'data': {},
          },
          {
            'id': '3',
            'type': 'system',
            'title': 'تنبيه أمني',
            'body':
                'تم تسجيل الدخول إلى حسابك من جهاز جديد، إذا لم تكن أنت فيرجى مراجعة إعدادات الأمان.',
            'created_at': '10:15 م',
            'read': 0,
            'data': {},
          },
          {
            'id': '4',
            'type': 'reminder',
            'title': 'لا تنسى استخدام كوبونك!',
            'body':
                'باقي يوم واحد فقط على انتهاء صلاحية كوبون الخصم الخاص بك بحد أقصى 50 جنيهاً.',
            'created_at': '06:00 م',
            'read': 1,
            'data': {},
          },
        ],
        'pagination': {
          'total': 4,
          'count': 4,
          'per_page': 10,
          'current_page': 1,
          'total_pages': 1,
        },
      },
    });
  }

  @override
  List<NotificationEntity> parseItems(json) => (json['data'] as List)
      .map((e) => NotificationEntity.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  @override
  PaginationMeta parsePagination(json) =>
      PaginationMeta.fromJson(json['pagination']);

  void clearData() async {
    setSuccess(data: PaginatedData.initial());
  }

  void deleteOneNotification(NotificationEntity notification) async {
    final updatedItems = List<NotificationEntity>.from(state.data.items)
      ..removeWhere((element) => element.id == notification.id);
    setSuccess(data: state.data.copyWith(items: updatedItems));
  }
}
