import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

class DoneActionBottomSheet extends StatelessWidget {
  final String title;
  const DoneActionBottomSheet({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppAssets.svg.baseSvg.doneAction.image(height: 120.h),
        24.szH,
        Text(
          title,
          style: context.textStyle.s18.bold,
          textAlign: TextAlign.center,
        ),
        50.szH,
      ],
    );
  }
}
