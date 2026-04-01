part of '../imports/view_imports.dart';

@injectable
class UpdatePhotoCubit extends AsyncCubit<UserModel?> {
  UpdatePhotoCubit() : super(null);

  Future<void> updatePhoto({required File file}) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.uploadPhoto,
          isFromData: true,
          body: {
            'photo_profile': await MultipartFile.fromFile(file.path),
            '_method': 'put',
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => UserModel.fromJson(json),
        ),
      ),
      successEmitter: (user) async {
        if (user != null) {
          await UserCubit.instance.updateUser(user);
          await UserCubit.instance.getProfile();
          MessageUtils.showSnackBar(
            message: LocaleKeys.successUpdatePhoto,
            baseStatus: BaseStatus.success,
          );
        }
      },
    );
  }
}
