import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/widgets/sized_box_helper.dart';

class InternetExpetion extends StatefulWidget {
  const InternetExpetion({super.key, required this.isNotConnected});
  final bool isNotConnected;
  @override
  State<InternetExpetion> createState() => _InternetExpetionState();
}

class _InternetExpetionState extends State<InternetExpetion>
    with SingleTickerProviderStateMixin {
  bool isDissmised = false;
  late bool isNotConnected = widget.isNotConnected;
  bool isRestored = false;
  @override
  didUpdateWidget(InternetExpetion oldWidget) {
    super.didUpdateWidget(oldWidget);

    isRestored = false;
    if (oldWidget.isNotConnected != widget.isNotConnected) {
      isDissmised = false;
      if (!widget.isNotConnected) {
        isRestored = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          isNotConnected = widget.isNotConnected;
          setState(() {});
          _controller.reset();
          _controller.stop();
        });
      } else {
        _controller.reset();
        _controller.forward();
        setState(() {
          isNotConnected = widget.isNotConnected;
        });
      }
    }
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  final List<IconData> _icons = [
    Icons.wifi_1_bar,
    Icons.wifi_2_bar,
    Icons.wifi,
  ];

  int _currentIconIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() {
          _currentIconIndex = (_currentIconIndex + 1) % _icons.length;
        });
      }
    });
    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 500), _startAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: isDissmised,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isDissmised = true;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          height: isNotConnected ? 50.h : 0,
          width: context.mediaQuery.size.width,
          decoration: BoxDecoration(
            color: isRestored ? AppColors.primary : AppColors.grey1,
          ),
          child: AnimatedSwitcher(
            duration: 500.ms,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isRestored
                      ? LocaleKeys.internetConnectionRestored
                      : LocaleKeys.errorExceptionNoconnection,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleSmall!.copyWith(
                    color: isRestored ? AppColors.white : AppColors.error,
                  ),
                ),
                10.w.szW,
                if (isNotConnected)
                  Icon(
                    isRestored ? Icons.wifi : _icons[_currentIconIndex],
                    size: 30.h,
                    color: isRestored ? AppColors.white : AppColors.error,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
