part of 'config_imports.dart';

class AppColors {
  static const Color main = Color(0xFF1C1C1C);
  static const Color primary = Color(0xFF474747);
  static const Color secondary = Color(0xFF292929);
  static const Color third = Color(0xFF1F2A37);
  static const Color forth = Color(0xFF583D82);
  static const Color hintText = Color(0xFF666666);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color buttonColor = Color(0xFF583D82);
  static const Color buttonText = Color(0xffF7F7F8);

  static const Color scaffoldBackground = Color(0xffFFFFFF);
  static const Color border = Color(0xFFC5C6C9);
  static const Color activeBorder = Color(0xFF583D82);
  static const Color error = Color(0xFFE34D4D);

  static const Color grey1 = Color(0xffDFDFDF);
  static const Color grey2 = Color(0xFFC7C7C7);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xFF1C1C1C), Color(0xFF292929)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient disableGradient = LinearGradient(
    colors: [grey1, grey2],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static BoxShadow containerShadow = BoxShadow(
    color: const Color(0xFFF0F0F0).withValues(alpha: 1.0),
    offset: const Offset(0, 0),
    blurRadius: 4.0,
    spreadRadius: 0.0,
  );
}

extension ColorExtension on Color {
  bool get isDark => computeLuminance() < 0.5;
}

class AppColorsWithDarkMode {
  static const Color main = Color(0xFF1C1C1C);
  static const Color primary = Color(0xFF474747);
  static const Color secondary = Color(0xFF292929);
  static const Color third = Color(0xFF1F2A37);
  static const Color forth = Color(0xFF583D82);
  static const Color hintText = Color(0xFF666666);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color buttonColor = Color(0xFF583D82);
  static const Color buttonText = Color(0xffF7F7F8);

  static const Color scaffoldBackground = Color(0xffFFFFFF);
  static const Color border = Color(0xFFC5C6C9);
  static const Color activeBorder = Color(0xFF583D82);
  static const Color error = Color(0xFFE34D4D);

  static const Color grey1 = Color(0xffDFDFDF);
  static const Color grey2 = Color(0xFFC7C7C7);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xffFB3D46), Color(0xffF72E92)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient disableGradient = LinearGradient(
    colors: [grey1, grey2],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static BoxShadow containerShadow = BoxShadow(
    color: const Color(0xFFF0F0F0).withValues(alpha: 1.0),
    offset: const Offset(0, 0),
    blurRadius: 4.0,
    spreadRadius: 0.0,
  );
}
