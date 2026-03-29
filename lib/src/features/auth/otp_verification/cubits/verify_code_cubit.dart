import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/features/auth/reset_password/imports/reset_password_imports.dart';

import '../../../../core/extensions/base_state.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/custom_messages.dart';

class VerifyCodeCubit extends AsyncCubit<String?> {
  VerifyCodeCubit() : super(null);

  Future<void> fVerifyCode({
    required String email,
    required String code,
  }) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.checkResetCode,
          body: {'email': email, 'code': code},
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
      successEmitter: (message) {
        Go.to(ResetPasswordScreen(email: email, code: code));
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: message ?? '',
        );
      },
    );
  }
}
