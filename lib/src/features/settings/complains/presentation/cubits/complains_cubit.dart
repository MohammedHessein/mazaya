part of '../imports/view_imports.dart';

@injectable
class ComplainsCubit extends AsyncCubit<List<ComplainEntity>> {
  ComplainsCubit() : super([]);

  Future<void> fetchComplains() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.complain,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => (json['data']['data'] as List)
              .map((e) => ComplainEntity.fromJson(e))
              .toList(),
        ),
      ),
      showErrorToast: false,
    );
  }
}
