part of '../imports/view_imports.dart';

@injectable
class DeleteAccountCubit extends AsyncCubit<String> {
  DeleteAccountCubit() : super("");

  Future<void> deleteAccount({void Function(String)? successEmitter}) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call<String>(
        CrudBaseParams(
          api: ApiConstants.deleteAccount,
          httpRequestType: HttpRequestType.delete,
          mapper: (json) => BaseModel.fromJson(json).message,
        ),
      ),
      successEmitter: (success) {
        UserCubit.instance.logout(clearOnboarding: true);
        if (successEmitter != null) {
          successEmitter(success);
        }
      },
    );
  }
}
