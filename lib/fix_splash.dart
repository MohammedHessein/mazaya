import 'dart:io';

import 'package:image/image.dart' as img;

void main() async {
  final inputPath = 'assets/svg/app_svg/android_12_splash.png';
  final outputPath = 'assets/svg/app_svg/android_12_fixed.png';

  print('Loading image: $inputPath');
  final bytes = await File(inputPath).readAsBytes();
  final image = img.decodeImage(bytes);

  if (image == null) {
    print('Failed to decode image');
    return;
  }

  print('Original size: ${image.width}x${image.height}');

  // Create a 1152x1152 canvas (Android 12 standard splash icon size)
  final canvasSize = 1152;
  final canvas = img.Image(width: canvasSize, height: canvasSize);

  // Clear with white background
  img.fill(canvas, color: img.ColorRgb8(255, 255, 255));

  // Scale the logo to fit in the safe zone
  final targetLogoSize = 1100;
  final scaledLogo = img.copyResize(
    image,
    width: targetLogoSize,
    interpolation: img.Interpolation.linear,
  );

  // Calculate centering coordinates
  final x = (canvasSize - scaledLogo.width) ~/ 2;
  final y = (canvasSize - scaledLogo.height) ~/ 2;

  print(
    'Centering logo at ($x, $y) with size ${scaledLogo.width}x${scaledLogo.height}',
  );

  // Composite the logo onto the canvas
  img.compositeImage(canvas, scaledLogo, dstX: x, dstY: y);

  print('Saving fixed image to: $outputPath');
  await File(outputPath).writeAsBytes(img.encodePng(canvas));
  print('Done!');
}
