import 'dart:io';

import 'package:image/image.dart' as img;

void main() async {
  final inputPath = 'assets/svg/app_svg/app_launcher_icon.png';
  final outputPath = 'assets/svg/app_svg/android_12_fixed.png';

  print('Loading high-res image: $inputPath');
  final bytes = await File(inputPath).readAsBytes();
  final image = img.decodeImage(bytes);

  if (image == null) {
    print('Failed to decode image');
    return;
  }

  print('Original size: ${image.width}x${image.height}');

  // Remove black background using flood fill from corners to preserve black elements inside the logo
  print('Processing flood fill background removal...');
  final visited = List.generate(image.height, (_) => List.filled(image.width, false));
  final queue = <List<int>>[];

  // Start from all four corners
  final corners = [
    [0, 0],
    [image.width - 1, 0],
    [0, image.height - 1],
    [image.width - 1, image.height - 1]
  ];

  for (final corner in corners) {
    if (!visited[corner[1]][corner[0]]) {
      queue.add([corner[0], corner[1]]);
      visited[corner[1]][corner[0]] = true;
    }
  }

  while (queue.isNotEmpty) {
    final pos = queue.removeAt(0);
    final x = pos[0];
    final y = pos[1];

    final pixel = image.getPixel(x, y);
    // If the pixel is very dark, it's part of the background
    if (pixel.r < 40 && pixel.g < 40 && pixel.b < 40) {
      image.setPixel(x, y, img.ColorRgba8(0, 0, 0, 0));

      // Check neighbors
      final neighbors = [
        [x + 1, y],
        [x - 1, y],
        [x, y + 1],
        [x, y - 1]
      ];

      for (final n in neighbors) {
        final nx = n[0];
        final ny = n[1];
        if (nx >= 0 && nx < image.width && ny >= 0 && ny < image.height && !visited[ny][nx]) {
          visited[ny][nx] = true;
          queue.add([nx, ny]);
        }
      }
    }
  }

  // Create a 1152x1152 canvas (Android 12 standard splash icon size)
  final canvasSize = 1152;
  final canvas = img.Image(width: canvasSize, height: canvasSize);

  // Clear with white background (#ffffff)
  img.fill(canvas, color: img.ColorRgb8(255, 255, 255));

  // Scale the logo to fit in the safe zone (768px circle, we use 720px for safety)
  final targetLogoSize = 720;
  final scaledLogo = img.copyResize(
    image,
    width: targetLogoSize,
    interpolation: img.Interpolation.cubic,
  );

  // Calculate centering coordinates
  final dx = (canvasSize - scaledLogo.width) ~/ 2;
  final dy = (canvasSize - scaledLogo.height) ~/ 2;

  print(
    'Centering logo at ($dx, $dy) with size ${scaledLogo.width}x${scaledLogo.height}',
  );

  // Composite the logo onto the canvas
  img.compositeImage(canvas, scaledLogo, dstX: dx, dstY: dy);

  print('Saving fixed image to: $outputPath');
  await File(outputPath).writeAsBytes(img.encodePng(canvas));
  print('Done!');
}
