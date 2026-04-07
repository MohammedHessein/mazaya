import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';

import '../../model/home_model.dart';

@lazySingleton
class HomeCubit extends AsyncCubit<HomeModel?> {
  HomeCubit() : super(null);

  Future<void> getHomeData() async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.home,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => HomeModel.fromJson(json),
        ),
      ),
    );
  }

  void toggleLocal(int id) {
    final currentModel = state.data;
    if (currentModel == null) return;

    final updatedProducts = currentModel.products.map((p) {
      if (p.id == id) {
        return p.copyWith(isFav: !p.isFav);
      }
      return p;
    }).toList();

    setSuccess(data: currentModel.copyWith(products: updatedProducts));
  }

  void clear() {
    emit(AsyncState.initial(data: null));
  }
}
