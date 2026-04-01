import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/shared/models/user_model.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';
import 'package:mazaya/src/features/main/presentation/view/main_screen.dart';

@injectable
class UpdateProfileCubit extends AsyncCubit<UserModel?> {
  UpdateProfileCubit() : super(null);

  Future<void> updateProfile({
    String? name,
    String? email,
    String? locationId,
    String? address,
    bool isUpdate = false,
  }) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.updateProfile,
          isFromData: false,
          body: {
            if (name != null) 'name': name,
            if (email != null) 'email': email,
            if (locationId != null) 'location_id': locationId,
            if (address != null) 'address': address,
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => UserModel.fromJson(json),
        ),
      ),
      successEmitter: (user) async {
        if (user != null) {
          CacheStorage.write(ConstantManager.selectedLocation, true);
          await UserCubit.instance.updateUser(user);
          if (isUpdate) {
            Go.back();
          } else {
            Go.offAll(const MainScreen());
          }
          MessageUtils.showSnackBar(
            message: LocaleKeys.successUpdateProfile,
            baseStatus: BaseStatus.success,
          );
        }
      },
    );
  }
}
