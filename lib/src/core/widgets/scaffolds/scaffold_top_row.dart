import 'package:flutter_bloc/flutter_bloc.dart';
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
                      width: 60.r,
                      height: 60.r,
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
                        Text(
                          user.name,
                          style: context.textStyle.s14.regular.setWhiteColor,
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Go.to(const NotificationScreen()),
                  icon: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 0.5),
                    ),
                    child: Badge(
                      smallSize: 8,
                      alignment: AlignmentDirectional.topStart,
                      child: AppAssets.svg.baseSvg.notificationHome.svg(),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (config.showBackButton)
            IconButton(
              onPressed: Go.back,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          Center(
            child: Text(
              config.title,
              style: context.textStyle.s16.medium.setWhiteColor,
            ),
          ),
          config.trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
