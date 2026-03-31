part of '../imports/view_imports.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;
    final imageUrl = user.photoProfile;
    final bool isNetworkImage = imageUrl.startsWith('http');

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1),
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
    );
  }
}
