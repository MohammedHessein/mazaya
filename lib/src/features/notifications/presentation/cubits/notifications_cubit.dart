part of '../imports/view_imports.dart';

@injectable
class NotificationsCubit extends PaginatedCubit<NotificationEntity> {
  NotificationsCubit()
    : super(
        itemMapper: (json) =>
            NotificationEntity.fromJson(Map<String, dynamic>.from(json)),
      );

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? searchQuery,
  }) async {
    return await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.notifications,
        httpRequestType: HttpRequestType.get,
        queryParameters: ConstantManager.paginateJson(page),
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<NotificationEntity> parseItems(dynamic json) {
    if (json == null) return [];
    // The items list is nested at json['data']['data'] in the provided log
    final listData = json['data']?['data'] ?? json['data'] ?? json;
    
    if (listData is List) {
      return listData
          .map(
            (e) => NotificationEntity.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    }
    return super.parseItems(json);
  }

  @override
  PaginationMeta parsePagination(dynamic json) {
    if (json == null) {
      return const PaginationMeta(
        totalItems: 0,
        countItems: 0,
        perPage: 10,
        totalPages: 1,
        currentPage: 1,
      );
    }
    
    // Check if json['data'] itself contains the pagination fields
    final data = json['data'];
    final bool isDataMeta = data is Map<String, dynamic> && 
                            (data.containsKey('current_page') || data.containsKey('last_page'));

    final meta = json['meta'] ?? 
                 json['data']?['meta'] ?? 
                 json['pagination'] ??
                 (isDataMeta ? data : null);

    if (meta != null) {
      return PaginationMeta.fromJson(Map<String, dynamic>.from(meta));
    }
    return super.parsePagination(json);
  }

  void clearData() async {
    setSuccess(data: PaginatedData.initial());
  }

  void deleteOneNotification(NotificationEntity notification) async {
    final updatedItems = List<NotificationEntity>.from(state.data.items)
      ..removeWhere((element) => element.id == notification.id);
    setSuccess(data: state.data.copyWith(items: updatedItems));
  }
}
