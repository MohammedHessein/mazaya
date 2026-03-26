part of '../../imports/otp_verification_imports.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String username;
  const OtpVerificationScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VerifyCodeCubit()),
        BlocProvider(create: (context) => ResendCodeCubit()),
      ],
      child: DefaultScaffold(
        headerType: ScaffoldHeaderType.auth,
        title: LocaleKeys.verificationCode,
        body: OtpVerificationBody(username: username),
      ),
    );
  }
}
