part of '../imports/view_imports.dart';

@injectable
class ReadNotificationCubit extends AsyncCubit<String> {
  ReadNotificationCubit() : super("");

  Future<void> readNotification({
    required String notificationId,
    void Function(String)? successEmitter,
  }) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call<String>(
        CrudBaseParams(
          api: '${ApiConstants.readNotificationId}$notificationId/read',
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json).message,
        ),
      ),
      successEmitter: (data) {
        injector<NotificationCountCubit>().decrement();
        successEmitter?.call(data);
      },
    );
  }
}
