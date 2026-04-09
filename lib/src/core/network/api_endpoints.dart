class ApiConstants {
  static const String baseUrl =
      'https://backend.smartvision4p.com/mazaya-app/public/api/v1/';
  static const String login = 'user/login';
  static const String forgetPassword = 'user/forgot-password';
  static const String checkResetCode = 'user/check-reset-code';
  static const String resetPassword = 'user/reset-password';
  static const String changePassword = 'user/change-password';
  static const String home = 'home';
  static const String categories = 'categorys';
  static const String coupons = 'coupons';
  static const String toggleFavorite = 'user/favorites/toggle';
  static const String favorites = 'user/favorites';
  static const String profile = 'user/profile';
  static const String logout = 'user/logout';
  static const String deleteAccount = 'user/delete-account';
  static const String countries = 'locations/governorates';
  static const String cities = 'locations/cities/';
  static const String districts = 'locations/districts/';
  static const String updateProfile = 'user/update-profile';
  static const String uploadPhoto = 'user/update-photo';
  static const String usedCoupons = 'user/coupons';
  static const String singleCoupon = 'coupons/';
  static const String scanQR = 'user/coupons/scan/';
  static const String notifications = 'user/notifications';
  static const String readAllNotifications = 'user/notifications/read-all';
  static const String readNotificationId = 'user/notifications/';
  static const String termsAndConditions =
      'https://backend.smartvision4p.com/mazaya-app/public/term-conditions';
  static const String privacyPolicy =
      'https://backend.smartvision4p.com/mazaya-app/public/privacy-policy';
  static const String complaints = 'contact-us';
  static const String appSettings = 'setting';
  static const String updateLatLng = 'user/update-latlng';
}
