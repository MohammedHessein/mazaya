part of '../imports/view_imports.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  late final PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: ConstantManager.zero);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goHome() {
    Go.to(const HomeScreen());
  }

  void handleNext() {
    const Duration duration = Duration(milliseconds: 350);
    const Curve curve = Curves.easeOut;

    if (currentIndex < 2) {
      pageController.nextPage(duration: duration, curve: curve);
      return;
    }
    goHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: context.viewPadding.top + AppPadding.pH16,
              start: AppPadding.pW16,
            ),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: LanguagePill(onTap: () => openLanguageSheet(context)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppPadding.pH16,
              left: AppPadding.pW16,
              right: AppPadding.pW16,
              bottom: AppPadding.pH16,
            ),
            child: SizedBox(
              height: AppSize.sH50,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppAssets.svg.baseSvg.mazayaText.path,
                  height: AppSize.sH30,
                  width: context.width * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (index) => setState(() => currentIndex = index),
              children: [
                IntroSlide(
                  pageIndex: 0,
                  currentIndex: currentIndex,
                  onNext: handleNext,
                  onSkip: goHome,
                  imagePath: AppAssets.svg.baseSvg.onboarding1.path,
                ),
                IntroSlide(
                  pageIndex: 1,
                  currentIndex: currentIndex,
                  onNext: handleNext,
                  onSkip: goHome,
                  imagePath: AppAssets.svg.baseSvg.onboarding2.path,
                ),
                IntroSlide(
                  pageIndex: 2,
                  currentIndex: currentIndex,
                  onNext: handleNext,
                  onSkip: goHome,
                  imagePath: AppAssets.svg.baseSvg.onboarding3.path,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
