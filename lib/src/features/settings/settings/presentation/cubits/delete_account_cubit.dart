part of '../imports/view_imports.dart';

@injectable
class DeleteAccountCubit extends AsyncCubit<BaseModel?> {
  DeleteAccountCubit() : super(null);

  Future<void> deleteAccount() async {
    setLoading();
    final result = await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.deleteAccount,
        httpRequestType: HttpRequestType.delete,
        mapper: (json) => BaseModel.fromJson(json),
      ),
    );

    result.when(
      (success) async {
        await UserCubit.instance.logout();
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: success!.message,
        );
        // Go.offAll(const LoginScreen());
      },
      (error) {
        Go.back();
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.error,
          message: error.message,
        );
      },
    );
  }
}
