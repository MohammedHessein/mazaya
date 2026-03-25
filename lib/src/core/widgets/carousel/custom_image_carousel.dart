import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../image_widgets/cached_image.dart';

class CustomImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double? height;
  final double? width;
  final BoxFit? imageFit;
  final bool autoPlay;
  final Duration autoPlayDuration;
  final Curve autoPlayCurve;
  final BorderRadius? borderRadius;
  final Color? indicatorActiveColor;
  final Color? indicatorInactiveColor;

  const CustomImageCarousel({
    super.key,
    required this.imageUrls,
    this.height,
    this.width,
    this.imageFit,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.borderRadius,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
  });

  @override
  State<CustomImageCarousel> createState() => _CustomImageCarouselState();
}

class _CustomImageCarouselState extends State<CustomImageCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius:
                  widget.borderRadius ?? BorderRadius.circular(AppCircular.r2),
              child: CachedImage(
                url: widget.imageUrls[index],
                width: widget.width ?? double.infinity,
                height: widget.height,
                fit: widget.imageFit ?? BoxFit.cover,
                borderRadius:
                    widget.borderRadius ??
                    BorderRadius.circular(AppCircular.r2),
                placeHolder: Center(
                  child: Image.asset(
                    AppAssets.svg.baseSvg.onboarding1.path,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayDuration,
            autoPlayCurve: widget.autoPlayCurve,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: AppSize.sH10),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.imageUrls.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(entry.key),
          child: Container(
            width: AppSize.sW20,
            height: AppSize.sH2,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppCircular.r20),
              color: _currentIndex == entry.key
                  ? (widget.indicatorActiveColor ?? AppColors.forth)
                  : (widget.indicatorInactiveColor ?? AppColors.border),
            ),
          ),
        );
      }).toList(),
    );
  }
}
