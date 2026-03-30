part of '../imports/view_imports.dart';

class MoreMenuCardWidget extends StatelessWidget {
  final MoreItemEntity menuItem;

  const MoreMenuCardWidget({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r16),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: AppMargin.mH6),
      padding: menuItem.useSwitch
          ? EdgeInsets.symmetric(
              horizontal: AppPadding.pW12,
              vertical: AppPadding.pH4,
            )
          : EdgeInsets.all(AppPadding.pW12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          menuItem.icon.contains('.svg')
              ? SvgPicture.asset(
                  menuItem.icon,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondary,
                    BlendMode.srcIn,
                  ),
                )
              : Image.asset(menuItem.icon, width: 24.w, height: 24.w),
          5.szW,
          Expanded(
            child: Text(
              menuItem.title.tr(),
              style: context.textStyle.s14.regular.setMainTextColor,
            ),
          ),
          if (menuItem.useSwitch) ...[
            const SwitchNotifyWidget(),
          ] else ...[
            if (menuItem.trailingText != null)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8.w),
                child: Text(
                  menuItem.trailingText!.tr(),
                  style: context.textStyle.s14.regular.setColor(
                    AppColors.gray500,
                  ),
                ),
              ),
            if (!menuItem.disableArrow)
              context.isArabic
                  ? AppAssets.svg.baseSvg.moreArrowArabic.svg(
                      width: 20.w,
                      height: 20.w,
                    )
                  : RotatedBox(
                      quarterTurns: context.isRight ? 0 : 2,
                      child: AppAssets.svg.baseSvg.arrowBack.svg(
                        width: 20.w,
                        height: 20.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.greyB3,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
          ],
        ],
      ),
    ).onClick(onTap: menuItem.onTap);
  }
}
