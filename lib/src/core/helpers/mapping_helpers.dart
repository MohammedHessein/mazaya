class MappingHelpers {
  /// Robustly converts dynamic value to int.
  /// Handles Null, String, Int, and Double.
  static int toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? double.tryParse(value)?.toInt() ?? 0;
    }
    return 0;
  }

  /// Robustly converts dynamic value to double.
  /// Handles Null, String, Int, and Double.
  static double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  /// Robustly converts dynamic value to String.
  /// Handles Null and other types.
  static String toStringSafe(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  /// Robustly converts dynamic value to bool.
  /// Handles Null, Bool, Int (1/0), and String ("true"/"false", "1"/"0").
  static bool toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      final normalized = value.toLowerCase();
      return normalized == 'true' || normalized == '1';
    }
    return false;
  }
}
