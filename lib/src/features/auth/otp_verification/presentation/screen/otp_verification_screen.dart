part of '../../imports/otp_verification_imports.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VerifyCodeCubit()),
        BlocProvider(create: (context) => ForgetPasswordCubit()),
      ],
      child: DefaultScaffold(
        header: HeaderConfig(
          showBackButton: false,
          type: ScaffoldHeaderType.auth,
          title: LocaleKeys.verificationCode,
        ),
        slivers: [SliverToBoxAdapter(child: OtpVerificationBody(email: email))],
      ),
    );
  }
}
