import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'dart:developer';

import 'internet_exeption.dart';

class OfflineWidget extends StatefulWidget {
  final Widget child;
  const OfflineWidget({super.key, required this.child});

  @override
  State<OfflineWidget> createState() => _OfflineWidgetState();
}

class _OfflineWidgetState extends State<OfflineWidget> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder:
          (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool isNotConnected =
                connectivity.isEmpty ||
                connectivity.contains(ConnectivityResult.none);
            log('isNotConnected: $isNotConnected');
            return Stack(
              fit: StackFit.expand,
              children: [
                child,
                Positioned(
                  bottom: 110.h,
                  left: 25.w,
                  right: 25.w,
                  child: SafeArea(
                    top: false,
                    child: InternetExpetion(isNotConnected: isNotConnected),
                  ),
                ),
              ],
            );
          },
      builder: (BuildContext context) {
        return widget.child;
      },
      errorBuilder: (BuildContext context) =>
          const InternetExpetion(isNotConnected: false),
      // child: const SizedBox.shrink(),
    );
  }
}
