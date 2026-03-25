part of '../imports/view_imports.dart';

@injectable
class NotifiyCubit extends AsyncCubit<BaseModel?> {
  NotifiyCubit() : super(null);

  Future<void> switchNotifiy(ValueNotifier<bool> notifyNotifier) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.switchNotification,
          httpRequestType: HttpRequestType.patch,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (success) async {
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: success!.message,
        );
        final user = UserCubit.instance.user.copyWith(
          allowNotify: notifyNotifier.value,
        );
        await UserCubit.instance.updateUser(user);
      },
    );
  }
}
