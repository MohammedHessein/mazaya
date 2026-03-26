import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../core/network/api_endpoints.dart';

class ResendCodeCubit extends AsyncCubit<String?> {
  ResendCodeCubit() : super(null);

  Future<void> fResendCode({required String username}) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.forgetReSendCode,
          body: {'username': username},
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['message'],
        ),
      ),
    );
  }
}
