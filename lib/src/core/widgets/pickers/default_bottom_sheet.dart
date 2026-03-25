import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../../navigation/navigator.dart';

Future showDefaultBottomSheet({BuildContext? context, required Widget child}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context ?? Go.context,
    builder: (context) => DefaultSheetBody(child: child),
  );
}

class DefaultSheetBody extends StatelessWidget {
  final Widget child;
  const DefaultSheetBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.only(
                bottom: ScreenUtil().bottomBarHeight == 0
                    ? 10.h
                    : ScreenUtil().bottomBarHeight,
                left: 14.w,
                right: 14.w,
                top: 4.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Wrap(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  AppSize.sH14.szH,
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
