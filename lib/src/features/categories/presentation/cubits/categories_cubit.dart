import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/features/home/model/category_model.dart';

@injectable
class CategoriesCubit extends AsyncCubit<List<CategoryModel>> {
  CategoriesCubit() : super([]);

  Future<void> getCategories() async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.categories,
          httpRequestType: HttpRequestType.get,
          mapper: (json) {
            final data = json['data'] as List;
            return data.map((e) => CategoryModel.fromJson(e)).toList();
          },
        ),
      ),
    );
  }
}
