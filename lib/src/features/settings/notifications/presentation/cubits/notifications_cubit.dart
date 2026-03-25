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
  List<NotificationEntity> parseItems(json) => (json['data'] as List)
      .map((e) => NotificationEntity.fromJson(e))
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
