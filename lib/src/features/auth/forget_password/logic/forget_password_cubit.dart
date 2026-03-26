import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../core/network/api_endpoints.dart';

class ForgetPasswordCubit extends AsyncCubit<String?> {
  ForgetPasswordCubit() : super(null);

  Future<void> fForgetPassword({required String username}) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.forgetSendCode,
          body: {'username': username},
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
    );
  }
}
