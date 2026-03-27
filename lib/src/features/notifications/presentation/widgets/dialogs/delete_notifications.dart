part of '../../imports/view_imports.dart';

Future deleteNotifications({
  required DeleteNotificationCubit cubit,
  required String title,
  required Future<void> Function() onTap,
}) async {
  return showDefaultBottomSheet(
    child: BlocProvider.value(
      value: cubit,
      child: _DeleteAllNotificationBody(title: title, onTap: onTap),
    ),
  );
}

class _DeleteAllNotificationBody extends StatelessWidget {
  final String title;
  final Future<void> Function() onTap;
  const _DeleteAllNotificationBody({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: AppMargin.mH4,
      children: [
        AppAssets.svg.baseSvg.notificationDialog.image(
          width: context.width * .3,
          height: context.height * .14,
          fit: BoxFit.cover,
        ),
        AppSize.sH16.szH,
        Text(title, style: const TextStyle().setMainTextColor.s15.medium),
        Text(
          LocaleKeys.warning,
          style: const TextStyle().setSecondryColor.s11.regular,
        ),
        AppSize.sH10.szH,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppMargin.mW14,
          children: [
            Expanded(
              child: LoadingButton(
                height: AppSize.sH40,
                title: LocaleKeys.confirm,
                color: AppColors.error,
                onTap: onTap,
              ),
            ),
            Expanded(
              child: LoadingButton(
                height: AppSize.sH40,
                title: LocaleKeys.cancel,
                color: AppColors.white,
                textColor: AppColors.main,
                borderSide: const BorderSide(color: AppColors.border),
                onTap: () async => Go.back(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
