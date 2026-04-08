import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/shared/models/base_model.dart';
import 'package:mazaya/src/core/widgets/custom_messages.dart';

import '../../../../core/extensions/base_state.dart';
import '../../../coupons/presentation/view/view_imports.dart';

@injectable
class ComplaintsCubit extends AsyncCubit<String?> {
  ComplaintsCubit() : super(null);

  Future<void> submitComplaint({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.complaints,
          httpRequestType: HttpRequestType.post,
          body: {
            'name': name,
            'email': email,
            'mobile': phone,
            'message': message,
          },
          mapper: (json) => BaseModel.fromJson(json).message,
        ),
      ),
      successEmitter: (response) {
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: LocaleKeys.complaintSubmittedSuccessfully,
        );
        Go.back();
      },
    );
  }
}
