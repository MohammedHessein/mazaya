import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import '../../model/app_setting_model.dart';

@injectable
class AppSettingCubit extends AsyncCubit<AppSettingModel?> {
  AppSettingCubit() : super(null);

  Future<void> getSettings() async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call<AppSettingModel>(
        CrudBaseParams(
          api: ApiConstants.appSettings,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => AppSettingModel.fromJson(json),
        ),
      ),
    );
  }
}
