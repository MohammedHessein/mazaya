part of '../imports/view_imports.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IntroView();
  }
}

class _IntroView extends StatelessWidget {
  const _IntroView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _IntroBody());
  }
}

class _IntroBody extends StatelessWidget {
  const _IntroBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.viewPadding.top + AppPadding.pH16,
            left: AppPadding.pW16,
            right: AppPadding.pW16,
            bottom: AppPadding.pH16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppAssets.svg.baseSvg.mazayaText.path,
                height: 30.h,
                width: 150.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 125.w,
                child: AppDropdown<Languages>(
                  items: Languages.values,
                  value: Languages.currentLanguage,
                  itemAsString: (lang) => lang.title,
                  onChanged: (lang) {
                    if (lang != null) {
                      Languages.setLocaleWithContext(context, lang);
                    }
                  },
                  height: 48.h,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  fillColor: AppColors.black.withValues(alpha: 0.1),
                  isBordered: false,
                  style: context.textStyle.s15.setBlackColor.medium,
                  suffixIconColor: AppColors.black,
                  showSearchBox: false,
                  itemHeight: 50.h,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: IntroCarouselWidget(
            children: [
              IntroSectionWidget(
                introDto: IntroDto(
                  title: LocaleKeys.onboardingTitle1,
                  subtitle: LocaleKeys.onboardingDesc1,
                  backGroundImagePath: AppAssets.svg.baseSvg.onboarding1.path,
                  pointerImagePath: AppAssets.svg.baseSvg.carousel1.path,
                ),
              ),
              IntroSectionWidget(
                introDto: IntroDto(
                  title: LocaleKeys.onboardingTitle2,
                  subtitle: LocaleKeys.onboardingDesc2,
                  backGroundImagePath: AppAssets.svg.baseSvg.onboarding2.path,
                  pointerImagePath: AppAssets.svg.baseSvg.carousel2.path,
                ),
              ),
              IntroSectionWidget(
                introDto: IntroDto(
                  title: LocaleKeys.onboardingTitle3,
                  subtitle: LocaleKeys.onboardingDesc3,
                  backGroundImagePath: AppAssets.svg.baseSvg.onboarding3.path,
                  pointerImagePath: AppAssets.svg.baseSvg.carousel3.path,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
