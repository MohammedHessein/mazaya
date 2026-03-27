part of '../../imports/view_imports.dart';

Future deleteAccountModelSheet() async {
  return showDefaultBottomSheet(
    child: BlocProvider(
      create: (context) => injector<DeleteAccountCubit>(),
      child: const _DeleteAccountBody(),
    ),
  );
}

class _DeleteAccountBody extends StatelessWidget {
  const _DeleteAccountBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: AppMargin.mH4,
      children: [
        Center(
          child: AppAssets.lottie.wait.lottie(
            width: context.width * .5,
            height: context.height * .14,
            fit: BoxFit.cover,
          ),
        ),
        AppSize.sH16.szH,
        Text(
          LocaleKeys.settingsDeleteAccount,
          style: const TextStyle().setMainTextColor.s15.medium,
        ),
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
                onTap: () async =>
                    context.read<DeleteAccountCubit>().deleteAccount(),
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
