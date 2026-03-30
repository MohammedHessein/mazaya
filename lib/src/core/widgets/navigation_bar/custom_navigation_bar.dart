import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

import 'navigation_bar_entity.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
  });

  final List<NavigationBarEntity> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 25.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / tabs.length;
          final indicatorHeight = 70.h;
          final indicatorWidth = itemWidth - 10.w;

          return Container(
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.r50),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  left: context.isRight
                      ? (tabs.length - 1 - selectedIndex) * itemWidth +
                            (itemWidth - indicatorWidth) / 2
                      : selectedIndex * itemWidth +
                            (itemWidth - indicatorWidth) / 2,
                  top: (80.h - indicatorHeight) / 2,
                  child: Container(
                    width: indicatorWidth,
                    height: indicatorHeight,
                    decoration: BoxDecoration(
                      color: AppColors.blue50,
                      borderRadius: BorderRadius.circular(AppCircular.r50),
                    ),
                  ),
                ),
                Row(
                  children: List.generate(tabs.length, (index) {
                    final tab = tabs[index];
                    final isActive = selectedIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTabChange?.call(index),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIcon(
                              isActive
                                  ? (tab.activeIcon ?? tab.icon)
                                  : tab.icon,
                              isActive,
                            ),
                            2.szH,
                            Text(
                              tab.text,
                              style: const TextStyle()
                                  .copyWith(
                                    color: isActive
                                        ? AppColors.primary
                                        : AppColors.gray500,
                                  )
                                  .s11
                                  .medium,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(String path, bool isActive) {
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: 24.h,
        height: 24.h,
        colorFilter: !isActive
            ? const ColorFilter.mode(AppColors.gray500, BlendMode.srcIn)
            : null,
      );
    } else {
      return Image.asset(
        path,
        width: 24.h,
        height: 24.h,
        color: !isActive ? AppColors.gray500 : null,
      );
    }
  }
}
