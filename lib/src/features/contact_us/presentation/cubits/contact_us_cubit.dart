part of '../imports/contact_us_imports.dart';

@injectable
class ContactUsCubit extends AsyncCubit<BaseModel?> {
  ContactUsCubit() : super(null);

  Future<void> contactUs(ContactUsParams params) async {
    if (params.validate()) return;
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.contactUs,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (success) {
        Go.back();
        successDialog(
          context: Go.context,
          title: LocaleKeys.contactRequestSendSuccessfully,
        );
      },
    );
  }
}
