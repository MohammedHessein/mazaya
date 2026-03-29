import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/widgets/custom_messages.dart';

import '../../../../core/navigation/navigator.dart';
import '../../otp_verification/imports/otp_verification_imports.dart';

class ForgetPasswordCubit extends AsyncCubit<String?> {
  ForgetPasswordCubit() : super(null);

  Future<void> fForgetPassword({required String email}) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.forgetPassword,
          body: {'email': email},
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
      successEmitter: (message) {
        Go.to(OtpVerificationScreen(email: email));
        MessageUtils.showSnackBar(
          message: message ?? '',
          baseStatus: BaseStatus.success,
        );
      },
      showErrorToast: true,
    );
  }
}
