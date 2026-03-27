part of '../imports/view_imports.dart';

@injectable
class StaticPagesCubit extends AsyncCubit<String?> {
  StaticPagesCubit() : super(null);

  Future<void> fetchStaticPage(StaticPageTypeEnum pageType) async {
    await executeAsync(
      operation: () async {
        return await baseCrudUseCase.call<String>(
          CrudBaseParams(
            api: pageType.apiEndpoint,
            httpRequestType: HttpRequestType.get,
            mapper: (json) => json['data'],
          ),
        );
      },
      showErrorToast: false,
    );
  }
}
