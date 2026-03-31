import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import '../../model/home_model.dart';

@injectable
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

  Future<void> toggleFavorite(int id) async {
    final currentModel = state.data;
    if (currentModel == null) return;

    // Optimistic Update: Toggle isFav locally
    final updatedProducts = currentModel.products.map((p) {
      if (p.id == id) {
        return p.copyWith(isFav: !p.isFav);
      }
      return p;
    }).toList();

    setSuccess(data: currentModel.copyWith(products: updatedProducts));

    // Call API to sync with server
    await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.toggleFavorite,
        httpRequestType: HttpRequestType.post,
        body: {'product_id': id},
        mapper: (json) => json,
      ),
    );
  }
}
