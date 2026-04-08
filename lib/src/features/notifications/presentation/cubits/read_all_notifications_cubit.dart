part of '../imports/view_imports.dart';

@injectable
class ReadAllNotificationsCubit extends AsyncCubit<String> {
  ReadAllNotificationsCubit() : super("");

  Future<void> readAll({void Function(String)? successEmitter}) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call<String>(
        CrudBaseParams(
          api: ApiConstants.readAllNotifications,
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json).message,
        ),
      ),
      successEmitter: (data) {
        injector<NotificationCountCubit>().reset();
        successEmitter?.call(data);
      },
    );
  }
}
