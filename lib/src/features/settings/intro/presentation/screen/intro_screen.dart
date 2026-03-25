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
    return IntroCarouselWidget(
      children: [
        IntroSectionWidget(
          introDto: IntroDto(
            title: LocaleKeys.introWelcome,
            subtitle: LocaleKeys.introPlatforminfo,
            backGroundImagePath: AppAssets.svg.baseSvg.onboarding1.path,
            pointerImagePath: AppAssets.svg.baseSvg.carousel1.path,
          ),
        ),
        IntroSectionWidget(
          introDto: IntroDto(
            title: LocaleKeys.introExplore,
            subtitle: LocaleKeys.introBrowse,
            backGroundImagePath: AppAssets.svg.baseSvg.onboarding2.path,
            pointerImagePath: AppAssets.svg.baseSvg.carousel1.path,
          ),
        ),
        IntroSectionWidget(
          introDto: IntroDto(
            title: LocaleKeys.introFirststep,
            subtitle: LocaleKeys.introOverview,
            backGroundImagePath: AppAssets.svg.baseSvg.onboarding3.path,
            pointerImagePath: AppAssets.svg.baseSvg.carousel3.path,
          ),
        ),
      ],
    );
  }
}
