part of '../../imports/otp_verification_imports.dart';

class OtpVerificationBody extends StatefulWidget {
  final String username;
  const OtpVerificationBody({super.key, required this.username});

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  int _timerSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timerSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _timerSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VerifyCodeCubit, AsyncState<String?>>(
          listener: (context, state) {
            if (state.isSuccess) {
              Go.to(
                ResetPasswordScreen(
                  username: widget.username,
                  code: otpController.text,
                ),
              );
            }
          },
        ),
        BlocListener<ResendCodeCubit, AsyncState<String?>>(
          listener: (context, state) {
            if (state.isSuccess) {
              _startTimer();
            }
          },
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      UniversalMediaWidget(
                        path: AppAssets.svg.baseSvg.lock.path,
                      ),
                      context.isArabic
                          ? Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys.verificationCode1,
                                    style: context.textStyle.s20.bold,
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.verificationCode2,
                                    style: context
                                        .textStyle
                                        .s20
                                        .bold
                                        .setPrimaryColor,
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              LocaleKeys.verificationCode,
                              style: context.textStyle.s20.bold.setPrimaryColor,
                            ),
                      8.szH,
                      Text(
                        '${LocaleKeys.enterCodeSentTo} ${widget.username}',
                        textAlign: TextAlign.center,
                        style: context.textStyle.s14.regular.setHintColor,
                      ),
                      30.szH,
                      CustomPinTextField(controller: otpController),
                      20.szH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.codeNotSent,
                            style: context.textStyle.s14.regular.setHintColor,
                          ),
                          BlocBuilder<ResendCodeCubit, AsyncState<String?>>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed:
                                    _timerSeconds == 0 && !state.isLoading
                                    ? () {
                                        context
                                            .read<ResendCodeCubit>()
                                            .fResendCode(
                                              username: widget.username,
                                            );
                                      }
                                    : null,
                                child: Text(
                                  LocaleKeys.resendCode,
                                  style: context.textStyle.s14.bold.setColor(
                                    _timerSeconds == 0
                                        ? AppColors.primary
                                        : AppColors.gray400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      8.szH,
                      if (_timerSeconds > 0)
                        Text(
                          '00:${_timerSeconds.toString().padLeft(2, '0')}',
                          style: context.textStyle.s14.bold.setPrimaryColor,
                        ),
                      const Spacer(),
                      LoadingButton(
                        title: LocaleKeys.verify,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // await context.read<VerifyCodeCubit>().fVerifyCode(
                            //   username: widget.username,
                            //   code: otpController.text,
                            // );
                            Go.to(ResetPasswordScreen(
                              username: widget.username,
                              code: otpController.text,
                            ));
                          }
                        },
                      ),
                      20.szH,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
