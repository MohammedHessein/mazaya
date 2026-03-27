part of '../imports/view_imports.dart';

@injectable
class LangCubit extends AsyncCubit<BaseModel?> {
  LangCubit() : super(null);

  Future<void> changeLang(Languages lang) async {
    await executeAsync(
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.changeLang,
          body: {'lang': lang.languageCode},
          httpRequestType: HttpRequestType.patch,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
    );
  }
}
