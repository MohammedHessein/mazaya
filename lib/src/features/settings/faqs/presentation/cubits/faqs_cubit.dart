part of '../imports/view_imports.dart';

@injectable
class FaqsCubit extends AsyncCubit<List<FaqEntity>> {
  FaqsCubit() : super([]);

  Future<void> fetchFaqs() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.faqs,
          httpRequestType: HttpRequestType.get,
          mapper: (json) =>
              (json['data'] as List).map((e) => FaqEntity.fromJson(e)).toList(),
        ),
      ),
      showErrorToast: false,
    );
  }
}
