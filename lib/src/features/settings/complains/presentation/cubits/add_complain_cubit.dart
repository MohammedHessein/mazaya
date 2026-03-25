part of '../imports/view_imports.dart';

@injectable
class AddComplainCubit extends AsyncCubit<BaseModel?> {
  AddComplainCubit() : super(null);

  Future<void> addComplain(
    AddComplainParam params,
    BuildContext context,
  ) async {
    if (params.validate()) return;
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.addComplain,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (success) async {
        await context.read<ComplainsCubit>().fetchComplains();
        Go.back();
        if (!context.mounted) return;
        successDialog(
          context: context,
          title: LocaleKeys.complaintsSuccessMsg,
          desc: LocaleKeys.complaintsReviewMsg,
        );
      },
    );
  }
}
