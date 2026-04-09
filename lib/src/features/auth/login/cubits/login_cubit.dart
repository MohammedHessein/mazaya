import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

@injectable
class LoginCubit extends AsyncCubit<UserModel?> {
  LoginCubit() : super(null);

  Future<void> login(String username, String password) async {
    final String fcmToken = NotificationService.deviceToken.isEmpty
        ? 'no'
        : NotificationService.deviceToken;
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.login,
          isFromData: false,
          body: {
            'username': username,
            'password': password,
            'fcm_id': fcmToken,
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => UserModel.fromJson(json),
        ),
      ),
      successEmitter: (user) async {
        if (user != null && user.token != null) {
          await UserCubit.instance.setUserLoggedIn(
            user: user,
            token: user.token!,
          );
          await UserCubit.instance.getProfile();
          final bool isLocationSelected =
              CacheStorage.read(ConstantManager.selectedLocation) ?? false;
          if (user.locationId != null && isLocationSelected) {
            Go.offAll(const MainScreen());
          } else {
            Go.offAll(const SelectLocationScreen());
          }
          MessageUtils.showSnackBar(
            message: LocaleKeys.successLogin,
            baseStatus: BaseStatus.success,
          );
        }
      },
    );
  }
}
