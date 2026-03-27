part of '../../imports/view_imports.dart';

class _AddComplainBody extends StatefulWidget {
  const _AddComplainBody();

  @override
  State<_AddComplainBody> createState() => _AddComplainBodyState();
}

class _AddComplainBodyState extends State<_AddComplainBody> {
  final AddComplainParam params = AddComplainParam();

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddComplainCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH10,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: params.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppMargin.mH10,
                children: [
                  CustomTextFiled(
                    controller: params.reasonController,
                    hint: LocaleKeys.complaintsReasonHint,
                    title: LocaleKeys.complaintsReasonLabel,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.complaintsReasonLabel,
                    ),
                  ),
                  CustomTextFiled(
                    hint: LocaleKeys.complaintsDetailsHint,
                    title: LocaleKeys.complaintsDetailsLabel,
                    isOptional: true,
                    controller: params.detailsController,
                    maxLines: ConstantManager.maxLines,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.complaintsDetailsLabel,
                    ),
                  ),
                  AppSize.sH10.szH,
                  _ComplainImagesWidget(params),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: LoadingButton(
            title: LocaleKeys.complaintsAddBtn,
            onTap: () async => await cubit.addComplain(params, context),
          ),
        ),
      ],
    ).paddingAll(AppPadding.pH14);
  }
}

class _ComplainImagesWidget extends StatelessWidget {
  final AddComplainParam params;
  const _ComplainImagesWidget(this.params);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH20,
      children: [
        Text(
          LocaleKeys.complaintsUploadPhotos,
          style: const TextStyle().setMainTextColor.s14.regular,
        ),
        ValueListenableBuilder(
          valueListenable: params.imagesNotifer,
          builder: (context, value, child) {
            return Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: AppMargin.mH12,
              runSpacing: AppMargin.mH20,
              children: [
                AppAssets.svg.baseSvg.uploadDoted
                    .image(width: AppSize.sH70, height: AppSize.sH70)
                    .onClick(onTap: () => params.selectImages()),

                ...value.map(
                  (e) => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.file(
                        e.file!,
                        width: AppSize.sH70,
                        height: AppSize.sH70,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: -AppMargin.mH12,
                        left: -AppMargin.mW10,
                        child: AppAssets.svg.baseSvg.dropDownClose
                            .svg(width: AppSize.sH25, height: AppSize.sH25)
                            .onClick(onTap: () => params.removeImage(e)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
