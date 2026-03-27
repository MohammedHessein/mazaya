part of '../imports/view_imports.dart';

@injectable
class LogOutCubit extends AsyncCubit<BaseModel?> {
  LogOutCubit() : super(null);

  Future<void> logout() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.logOut,
          httpRequestType: HttpRequestType.post,
          body: {
            'device_id': await Helpers.getFcmToken(),
            'device_type': Helpers.getDeviceType(),
          },
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (data) {
        UserCubit.instance.logout();
        // Go.offAll(const LoginScreen());
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: data!.message,
        );
      },
    );
  }
}
