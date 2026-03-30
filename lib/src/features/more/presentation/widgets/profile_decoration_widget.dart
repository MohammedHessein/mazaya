part of '../imports/view_imports.dart';

class ProfileDecorationWidget extends StatelessWidget {
  final MembershipType membershipType;

  const ProfileDecorationWidget({super.key, required this.membershipType});

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;
    final imageUrl = user.photoProfile;
    final userName = user.name;
    final subTitle = membershipType == MembershipType.golden
        ? LocaleKeys.goldMember
        : membershipType == MembershipType.sliver
        ? LocaleKeys.silverMember
        : LocaleKeys.diamondMember;
    final bool isNetworkImage = imageUrl.startsWith('http');

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            alignment: Alignment.center,
            children: [
              Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.w),
                  child: imageUrl.isNotEmpty
                      ? (isNetworkImage
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.gray100,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  size: 50.w,
                                  color: AppColors.gray400,
                                ),
                              )
                            : Image.asset(imageUrl, fit: BoxFit.cover))
                      : Container(
                          color: AppColors.black,
                          child: Icon(
                            Icons.person,
                            size: 50.w,
                            color: AppColors.gray400,
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 5.w,
                left: 5.w,
                child: GestureDetector(
                  onTap: () {
                    // Handle image pick
                  },
                  child: Container(
                    padding: EdgeInsets.all(AppPadding.pH6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 16.w,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          20.szH,
          Text(
            userName.isNotEmpty ? userName : 'أدم علي',
            style: context.textStyle.s18.bold.setMainTextColor,
          ),
          if (subTitle.isNotEmpty) ...[
            12.szH,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW16,
                vertical: AppPadding.pH8,
              ),
              decoration: BoxDecoration(
                color: membershipType == MembershipType.golden
                    ? AppColors.orange.withValues(alpha: 0.1)
                    : membershipType == MembershipType.sliver
                    ? AppColors.gray200
                    : AppColors.blue100,
                borderRadius: BorderRadius.circular(AppCircular.r20),
                border: Border.all(color: Colors.transparent),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subTitle,
                    style: membershipType == MembershipType.golden
                        ? context.textStyle.s14.setColor(AppColors.orange)
                        : membershipType == MembershipType.sliver
                        ? context.textStyle.s14.setHintColor
                        : context.textStyle.s14.setColor(AppColors.primary),
                  ),
                  10.szW,
                  membershipType == MembershipType.sliver
                      ? AppAssets.svg.baseSvg.silverMember.svg(
                          width: 18.w,
                          height: 18.w,
                        )
                      : membershipType == MembershipType.golden
                      ? AppAssets.svg.baseSvg.goldenMember.svg(
                          width: 18.w,
                          height: 18.w,
                        )
                      : AppAssets.svg.baseSvg.diamondMember.svg(
                          width: 18.w,
                          height: 18.w,
                        ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
