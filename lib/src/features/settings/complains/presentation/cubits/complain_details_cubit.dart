part of '../imports/view_imports.dart';

@injectable
class ComplainsDetailsCubit extends AsyncCubit<ComplainEntity?> {
  ComplainsDetailsCubit() : super(null);

  Future<void> complainDetails(int id) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: "${ApiConstants.complainDetails}$id",
          httpRequestType: HttpRequestType.get,
          mapper: (json) => ComplainEntity.fromJson(json['data']),
        ),
      ),
      showErrorToast: false,
    );
  }
}
