import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  final filesToCrop = [
    {'path': 'assets/svg/app_svg/splash_android_11.png', 'padding': 40, 'targetHeight': 1000},
    {'path': 'assets/svg/app_svg/android_12_splash.png', 'padding': 200, 'targetHeight': 1152}, 
  ];

  for (var item in filesToCrop) {
    final path = item['path'] as String;
    final padding = item['padding'] as int;
    final targetHeight = item['targetHeight'] as int;
    
    final file = File(path);
    if (!file.existsSync()) continue;

    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) continue;

    int minX = image.width, maxX = 0, minY = image.height, maxY = 0;
    bool found = false;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        if (pixel.a > 0 && (pixel.r > 10 || pixel.g > 10 || pixel.b > 10)) {
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
          found = true;
        }
      }
    }

    if (found) {
      int newMinX = (minX - padding).clamp(0, image.width);
      int newMinY = (minY - padding).clamp(0, image.height);
      int newMaxX = (maxX + padding).clamp(0, image.width);
      int newMaxY = (maxY + padding).clamp(0, image.height);

      final cropped = img.copyCrop(image, x: newMinX, y: newMinY, width: newMaxX - newMinX, height: newMaxY - newMinY);
      
      // Scale up to ensure high resolution
      final scaled = img.copyResize(cropped, height: targetHeight, interpolation: img.Interpolation.linear);

      await file.writeAsBytes(img.encodePng(scaled));
      print('Resized $path to ${scaled.width}x${scaled.height}');
    }
  }
}
