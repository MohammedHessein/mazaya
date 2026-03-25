part of '../imports/view_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SplashCubit>(),
      child: _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().initApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        padding: EdgeInsets.all(AppPadding.pH20),
        decoration: const BoxDecoration(gradient: AppColors.gradient),
        child: AppAssets.svg.appSvg.appLogo.image(
          width: context.width * .3,
          height: context.height * .16,
        ),
      ),
    );
  }
}
