import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';

class VerifyCodeCubit extends AsyncCubit<String?> {
  VerifyCodeCubit() : super(null);

  Future<void> fVerifyCode({required String username, required String code}) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.forgetCheckCode,
          body: {
            'username': username,
            'code': code,
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
    );
  }
}
