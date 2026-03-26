part of '../../imports/reset_password_imports.dart';

class SuccessResetScreen extends StatelessWidget {
  const SuccessResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: '',
      headerType: ScaffoldHeaderType.auth,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(AppAssets.svg.baseSvg.lock.path),
            20.szH,
            Text(
              LocaleKeys.changePasswordSuccess,
              style: context.textStyle.s20.bold.setPrimaryColor,
              textAlign: TextAlign.center,
            ),
            8.szH,
            Text(
              LocaleKeys.loginSubtitle,
              textAlign: TextAlign.center,
              style: context.textStyle.s14.regular.setHintColor,
            ),
            const Spacer(),
            LoadingButton(
              width: double.infinity,
              title: LocaleKeys.login,
              onTap: () async {
                Go.offAll(const LoginScreen());
              },
            ),
            30.szH,
          ],
        ),
      ),
    );
  }
}
