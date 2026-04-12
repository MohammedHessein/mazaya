import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/image_widgets/cached_image.dart';
import 'package:mazaya/src/features/notifications/presentation/imports/view_imports.dart';

import '../../../features/location/imports/location_imports.dart';

class ScaffoldTopRow extends StatelessWidget {
  final HeaderConfig config;

  const ScaffoldTopRow({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    if (config.type == ScaffoldHeaderType.home) {
      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final user = state.userModel;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CachedImage(
                      url: user.image,
                      width: 80.r,
                      height: 80.r,
                      boxShape: BoxShape.circle,
                      borderColor: AppColors.white,
                      bgColor: AppColors.white,
                      fit: BoxFit.cover,
                    ),
                    12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.welcomeHome,
                          style: context.textStyle.s14.medium.setWhiteColor,
                        ),
                        Row(
                          children: [
                            if (user.userPackageName != null) ...[
                              Builder(
                                builder: (context) {
                                  final mType =
                                      user.memberType?.toLowerCase() ?? '';
                                  final membershipType =
                                      MembershipType.fromString(mType);

                                  final icon =
                                      membershipType == MembershipType.golden
                                      ? AppAssets.svg.baseSvg.goldenMember
                                      : membershipType == MembershipType.sliver
                                      ? AppAssets.svg.baseSvg.silverMember
                                      : membershipType ==
                                            MembershipType.volunteer
                                      ? AppAssets.svg.baseSvg.volunteer
                                      : AppAssets.svg.baseSvg.diamondMember;

                                  final color =
                                      membershipType == MembershipType.golden
                                      ? AppColors.yellow
                                      : membershipType == MembershipType.sliver
                                      ? AppColors.grey1
                                      : membershipType ==
                                            MembershipType.volunteer
                                      ? AppColors.success
                                      : AppColors.white;

                                  return icon.svg(
                                    width: 18.w,
                                    height: 18.w,
                                    color: color,
                                  );
                                },
                              ),
                            ],
                            6.szW,
                            Text(
                              user.name,
                              style:
                                  context.textStyle.s14.regular.setWhiteColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    injector<NotificationCountCubit>().reset();
                    Go.to(const NotificationScreen());
                  },
                  icon: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 0.5),
                    ),
                    child: BlocBuilder<NotificationCountCubit, int>(
                      builder: (context, state) {
                        return Badge(
                          label: state > 0 ? Text('$state') : null,
                          isLabelVisible: state > 0,
                          smallSize: 8,
                          alignment: AlignmentDirectional.topStart,
                          child: AppAssets.svg.baseSvg.notificationHome.svg(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          if (config.showBackButton)
            IconButton(
              onPressed: Go.back,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            )
          else if (config.trailing != null)
            const SizedBox(width: 48),
          const Spacer(),
          Text(
            config.title,
            style: context.textStyle.s16.medium.setWhiteColor,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          if (config.trailing != null)
            config.trailing!
          else if (config.showBackButton)
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
