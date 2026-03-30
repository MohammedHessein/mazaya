import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/pickers/done_action_bottom_sheet.dart';

import '../../../../core/navigation/navigator.dart';

@injectable
class ChangePasswordCubit extends AsyncCubit<String> {
  ChangePasswordCubit() : super('');

  Future<void> submitChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.changePassword,
          isFromData: false,
          body: {
            'current_password': currentPassword,
            'password': newPassword,
            'password_confirmation': confirmPassword,
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
      successEmitter: (response) async {
        showDefaultBottomSheet(child: DoneActionBottomSheet(title: response));
        await Future.delayed(const Duration(seconds: 2));
        Go.back();
        Go.back();
      },
    );
  }
}
