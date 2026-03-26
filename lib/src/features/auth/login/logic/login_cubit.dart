import 'package:injectable/injectable.dart';

import '../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../logic/home/presentation/imports/view_imports.dart';

@injectable
class LoginCubit extends AsyncCubit<String?> {
  LoginCubit() : super(null);

  Future<void> login(String username, String password) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.login,
          body: {
            'username': username,
            'password': password,
            'device_token': 'test_token',
            'type': 'ios',
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => json['data'],
        ),
      ),
      successEmitter: (token) {
        Go.offAll(const HomeScreen());
      },
    );
  }
}
