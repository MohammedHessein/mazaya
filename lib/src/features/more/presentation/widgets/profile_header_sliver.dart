part of '../imports/view_imports.dart';

class ProfileHeaderSliver extends StatelessWidget {
  const ProfileHeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    if (!UserCubit.instance.isUserLoggedIn) {
      return const AppHeaderSliver(
        config: HeaderConfig(
          type: ScaffoldHeaderType.profile,
          showBackButton: false,
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: double.infinity,
                height: 160.h,
                child: Image.asset(
                  AppAssets.svg.baseSvg.curveBackground.path,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                bottom: false,
                child: ScaffoldTopRow(
                  config: HeaderConfig(
                    type: ScaffoldHeaderType.profile,
                    showBackButton: false,
                  ),
                ),
              ),
              Positioned(
                bottom: -25.h,
                left: 0,
                right: 0,
                child: const ProfileAvatarWidget(),
              ),
            ],
          ),
          45.szH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
            child: Column(
              children: [
                const ProfileInfoWidget(),
                24.szH,
                const MemberShipCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
