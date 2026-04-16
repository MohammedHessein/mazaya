import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

@injectable
class UpdateProfileCubit extends AsyncCubit<UserModel?> {
  UpdateProfileCubit() : super(null);

  Future<void> updateProfile({
    String? name,
    String? email,
    String? locationId,
    String? address,
    String? poBox,
    String? nationalId,
    String? firstName,
    String? lastName,
    String? mobile,
    String? personalNumber,
    String? countryCode,
    bool isUpdate = false,
  }) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.updateProfile,
          isFromData: false,
          body: {
            'name': ?name,
            'email': ?email,
            'location_id': ?locationId,
            'address': ?address,
            'po_box': ?poBox,
            'national_id': ?nationalId,
            'first_name': ?firstName,
            'last_name': ?lastName,
            'mobile': ?mobile,
            'personalnumber': ?personalNumber,
            'country_code': ?countryCode,
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
