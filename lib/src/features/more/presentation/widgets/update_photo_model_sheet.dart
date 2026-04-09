part of '../imports/view_imports.dart';

Future updatePhotoModelSheet(BuildContext context) async {
  final cubit = context.read<UpdatePhotoCubit>();
  return showDefaultBottomSheet(
    context: context,
    child: BlocProvider.value(
      value: cubit,
      child: const UpdatePhotoBody(),
    ),
  );
}

class UpdatePhotoBody extends StatelessWidget {
  const UpdatePhotoBody({super.key});

  Future<void> _handleImageSelection(BuildContext context, File? file) async {
    if (file == null) return;

    final int sizeInBytes = await file.length();
    if (sizeInBytes > 10 * 1024 * 1024) {
      MessageUtils.showSnackBar(
        message: LocaleKeys.imageSizeError,
        baseStatus: BaseStatus.error,
      );
      return;
    }

    if (context.mounted) {
      final cubit = context.read<UpdatePhotoCubit>();
      Go.back();
      cubit.updatePhoto(file: file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSize.sH10.szH,
        Text(
          LocaleKeys.editPhotoProfile,
          style: context.textStyle.setMainTextColor.s16.bold,
        ),
        AppSize.sH30.szH,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UpdatePhotoItemWidget(
              title: LocaleKeys.camera,
              icon: AppAssets.svg.baseSvg.cameraAlt,
              onTap: () async {
                final file = await ImageHelper.takePicture();
                if (context.mounted) {
                  await _handleImageSelection(context, file);
                }
              },
            ),
            UpdatePhotoItemWidget(
              title: LocaleKeys.photoLibrary,
              icon: AppAssets.svg.baseSvg.gallery,
              onTap: () async {
                final file = await ImageHelper.pickImage();
                if (context.mounted) {
                  await _handleImageSelection(context, file);
                }
              },
            ),
          ],
        ),
        AppSize.sH30.szH,
      ],
    );
  }
}

class UpdatePhotoItemWidget extends StatelessWidget {
  final String title;
  final SvgGenImage icon;
  final VoidCallback onTap;

  const UpdatePhotoItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppPadding.pW20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(22.w),
              border: Border.all(color: AppColors.gray200, width: 1.w),
            ),
            child: icon.svg(width: 32.w, height: 32.w),
          ),
          AppSize.sH10.szH,
          Text(title, style: context.textStyle.setMainTextColor.s14.medium),
        ],
      ),
    );
  }
}
