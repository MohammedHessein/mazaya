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
  static const String termsAndConditions =
      'https://backend.smartvision4p.com/mazaya-app/public/term-conditions';
  static const String privacyPolicy =
      'https://backend.smartvision4p.com/mazaya-app/public/privacy-policy';

  static const String registerContent = 'user/get-register-data';
  static const String verifyAccount = 'user/auth/verify-account';
  static const String verifyAccountResendCode =
      'user/auth/verify-account-resend-code';
  static const String forgetReSendCode =
      'user/auth/forget-password/resend-code';
  static const String forgetCheckCode = 'user/auth/forget-password/verify-code';
  static const String notifications = 'user/notifications';
  static const String unReadNotifications = 'user/notifications/count-unread';
  static const String deleteNotification = 'user/notifications/delete/';
  static const String deleteAllNotifications = 'user/notifications/delete-all';
  static const String switchNotification = 'user/notifications/change-status';
  // static const String updateProfile = 'user/profile/update';
  static const String changeLang = 'user/change-lang';
  static const String updateCountry = 'user/profile/change-currency-country';
  static const String changeEmailCheckPassword =
      'user/profile/change-email-check-password';
  static const String changeEmailSendCode =
      'user/profile/change-email-send-code';
  static const String changeEmailReSendCode =
      'user/profile/change-email-resend-code';
  static const String changeEmailVerifyCode =
      'user/profile/change-email-verify-code';
  static const String faqs = 'get-faqs';
  static const String about = 'about';
  static const String contactUs = 'send-help-message';
  static const String complain = 'user/complaints/get-complaint-data';
  static const String addComplain = 'user/complaints/send';
  static const String complainDetails = 'user/complaints/';
}
