part of '../imports/view_imports.dart';

class _NotificationCardWidget extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const _NotificationCardWidget(this.notificationEntity);

  @override
  Widget build(BuildContext context) {
    final bool isUnread = notificationEntity.read == 0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH16,
      ),
      margin: EdgeInsets.symmetric(vertical: AppMargin.mH6),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppMargin.mW8,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isUnread ? const Color(0xFFF5F8FD) : AppColors.lightGray,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: (isUnread
                    ? AppAssets.svg.baseSvg.unReadNotification
                    : AppAssets.svg.baseSvg.readNotification)
                .svg(
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                isUnread ? const Color(0xFF2D6EC9) : AppColors.gray400,
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.mH4,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        notificationEntity.title,
                        textAlign: TextAlign.start,
                        style: context.textStyle.s14.medium.setMainTextColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      notificationEntity.createdAt,
                      style: context.textStyle.s12.regular.setColor(
                        AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                Text(
                  notificationEntity.body,
                  textAlign: TextAlign.start,
                  style: context.textStyle.s14.light.setColor(
                    AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).onClick(
      onTap: () => NotificationRoutes.navigateByType(notificationEntity.toMap),
    );
  }
}
