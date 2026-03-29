import 'package:injectable/injectable.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/shared/models/user_model.dart';
import 'package:mazaya/src/features/main/presentation/view/main_screen.dart';

import '../../../../core/widgets/custom_messages.dart';

@injectable
class LoginCubit extends AsyncCubit<UserModel?> {
  LoginCubit() : super(null);

  Future<void> login(String username, String password) async {
    final String fcmToken = NotificationService.deviceToken.isEmpty
        ? 'www'
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
          Go.offAll(const MainScreen());
          MessageUtils.showSnackBar(
            message: LocaleKeys.successLogin,
            baseStatus: BaseStatus.success,
          );
        }
      },
    );
  }
}
