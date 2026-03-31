import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/usecases/base_crud.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';

@injectable
class MoreDeleteAccountCubit extends AsyncCubit<String> {
  MoreDeleteAccountCubit() : super("");

  Future<void> deleteAccount({void Function(String)? successEmitter}) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call<String>(
        CrudBaseParams(
          api: ApiConstants.deleteAccount,
          httpRequestType: HttpRequestType.post,
          mapper: (response) => response['message']?.toString() ?? "Success",
        ),
      ),
      successEmitter: successEmitter,
    );
  }
}
