import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../core/network/api_endpoints.dart';

class ResetPasswordCubit extends AsyncCubit<String?> {
  ResetPasswordCubit() : super(null);

  Future<void> fResetPassword({
    required String username,
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.resetPassword,
          body: {
            'username': username,
            'code': code,
            'password': password,
            'password_confirmation': confirmPassword,
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
    );
  }
}
