import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/widgets/pickers/done_action_bottom_sheet.dart';
import 'package:mazaya/src/features/auth/login/imports/login_imports.dart';

import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/pickers/default_bottom_sheet.dart';

class ResetPasswordCubit extends AsyncCubit<String?> {
  ResetPasswordCubit() : super(null);

  Future<void> fResetPassword({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.resetPassword,
          body: {
            'email': email,
            'code': code,
            'password': password,
            'password_confirmation': confirmPassword,
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
      successEmitter: (message) async {
        showDefaultBottomSheet(
          context: Go.context,
          child: DoneActionBottomSheet(title: message ?? ''),
        );
        await Future.delayed(const Duration(seconds: 2));
        Go.back();
        Go.offAll(const LoginScreen());
      },
    );
  }
}
