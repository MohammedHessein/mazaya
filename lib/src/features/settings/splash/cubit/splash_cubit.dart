part of '../imports/view_imports.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  void initApp(BuildContext context) async {
    // Inject BaseUrl To Dio Service
    await injector<NetworkService>().updateBaseUrl();
    if (!context.mounted) return;
    await initUserData(context);
  }
}

Future<void> initUserData(BuildContext context) async {
  Future.delayed(
    const Duration(milliseconds: ConstantManager.splashTimer),
  ).then((value) async {
    final result = await UserCubit.instance.init();
    if (result) {
      Go.to(const HomeScreen());
    } else {
      Go.to(const IntroScreen());
    }
  });
}
