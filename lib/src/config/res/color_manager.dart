part of 'config_imports.dart';

class AppColors {
  static const Color primary = Color(0xff315EA1);
  static const Color secondary = Color(0xFF0E1317);
  static const Color main = Color(0xFF1A1A1A);
  static const Color orange = Color(0xFFF98B45);
  
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color bgF7 = Color(0xFFF7F7F7);
  
  static const Color hintText = Color(0xFF666666);
  static const Color placeholder = Color(0xFF999999);
  
  static const Color error = Color(0xFFCA0000);
  static const Color success = Color(0xFF00AD00);
  
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color greyB3 = Color(0xFFB3B3B3);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray100 = Color(0xFFF3F4F6);

  static const Color blue100 = Color(0xFFEAF0FA);
  static const Color blue50 = Color(0xFFF5F8FD);
  static const Color blue200 = Color(0xFFD5E2F5);
  static const Color blue400 = Color(0xFF8EB4EA);
  static const Color blue500 = Color(0xFF5E91DA);
  static const Color blue600 = Color(0xFF3F75C3);

  static const Color successBg = Color(0xFFE5FFE5);
  static const Color warningBg = Color(0xFFFFF4E5);
  static const Color selectedBg = Color(0xFFEDF1F7);

  // Aliases for backward compatibility and internal consistency
  static const Color border = lightGray;
  static const Color activeBorder = primary;
  static const Color buttonColor = primary;
  static const Color buttonText = white;
  static const Color third = gray500;
  static const Color forth = orange;

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
  static const Color primary = Color(0xff315EA1);
  static const Color secondary = Color(0xFF0E1317);
  static const Color main = Color(0xFF1A1A1A);
  static const Color orange = Color(0xFFF98B45);
  
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color bgF7 = Color(0xFFF7F7F7);
  
  static const Color hintText = Color(0xFF666666);
  static const Color placeholder = Color(0xFF999999);
  
  static const Color error = Color(0xFFCA0000);
  static const Color success = Color(0xFF00AD00);
  
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color greyB3 = Color(0xFFB3B3B3);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray100 = Color(0xFFF3F4F6);

  static const Color blue100 = Color(0xFFEAF0FA);
  static const Color blue50 = Color(0xFFF5F8FD);
  static const Color blue200 = Color(0xFFD5E2F5);
  static const Color blue400 = Color(0xFF8EB4EA);
  static const Color blue500 = Color(0xFF5E91DA);
  static const Color blue600 = Color(0xFF3F75C3);

  static const Color successBg = Color(0xFFE5FFE5);
  static const Color warningBg = Color(0xFFFFF4E5);
  static const Color selectedBg = Color(0xFFEDF1F7);

  // Aliases for backward compatibility and internal consistency
  static const Color border = lightGray;
  static const Color activeBorder = primary;
  static const Color buttonColor = primary;
  static const Color buttonText = white;
  static const Color third = gray500;
  static const Color forth = orange;

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
