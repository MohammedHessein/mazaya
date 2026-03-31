part of '../imports/view_imports.dart';

@injectable
class NotificationsCubit extends PaginatedCubit<NotificationEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
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
  List<NotificationEntity> parseItems(json) {
    if (json == null || json['data'] == null || json['data']['data'] == null) {
      return [];
    }
    return (json['data']['data'] as List)
        .map((e) => NotificationEntity.fromJson(Map<String, dynamic>.from(e)))
        .toList();
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

  void clearData() async {
    setSuccess(data: PaginatedData.initial());
  }

  void deleteOneNotification(NotificationEntity notification) async {
    final updatedItems = List<NotificationEntity>.from(state.data.items)
      ..removeWhere((element) => element.id == notification.id);
    setSuccess(data: state.data.copyWith(items: updatedItems));
  }
}
