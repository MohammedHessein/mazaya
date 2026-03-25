part of '../imports/intro_imports.dart';

class IntroDto {
  final String title;
  final String subtitle;

  final String backGroundImagePath;
  final String? pointerImagePath;

  const IntroDto({
    required this.title,
    required this.subtitle,
    required this.backGroundImagePath,
    required this.pointerImagePath,
  });
}
