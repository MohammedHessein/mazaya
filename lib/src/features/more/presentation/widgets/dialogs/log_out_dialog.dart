part of '../../imports/view_imports.dart';

Future logOut() async {
  return showDefaultBottomSheet(
    child: BlocProvider(
      create: (context) => injector<LogOutCubit>(),
      child: const _LogOutBody(),
    ),
  );
}

class _LogOutBody extends StatelessWidget {
  const _LogOutBody();

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
          LocaleKeys.logout,
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
                onTap: () async => context.read<LogOutCubit>().logout(),
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
