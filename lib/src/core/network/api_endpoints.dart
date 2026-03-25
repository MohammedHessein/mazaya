class ApiConstants {
  static const String baseUrl = 'https://your-api-url.com/api/';
  // ---------------------- Settings -----------------------------------
  static const String intro = 'get-intros';
  static const String countries = 'countries';
  static const String uploadFiles = 'upload-files';
  // ---------------------- Auth -----------------------------------
  static const String login = 'user/auth/login';
  static const String register = 'user/auth/register';
  static const String cities = 'cities-by-country/';
  static const String registerContent = 'user/get-register-data';
  static const String verifyAccount = 'user/auth/verify-account';
  static const String verifyAccountResendCode =
      'user/auth/verify-account-resend-code';
  static const String forgetSendCode = 'user/auth/forget-password/send-code';
  static const String forgetReSendCode =
      'user/auth/forget-password/resend-code';
  static const String forgetCheckCode = 'user/auth/forget-password/verify-code';
  static const String resetPassword =
      'user/auth/forget-password/reset-password';

  // ---------------------- Notifications -----------------------------------
  static const String notifications = 'user/notifications';
  static const String unReadNotifications = 'user/notifications/count-unread';
  static const String deleteNotification = 'user/notifications/delete/';
  static const String deleteAllNotifications = 'user/notifications/delete-all';

  // ---------------------- Settings -----------------------------------
  static const String switchNotification = 'user/notifications/change-status';
  static const String updateProfile = 'user/profile/update';
  static const String changePassword = 'user/profile/update-password';
  static const String changeLang = 'user/change-lang';
  static const String deleteAccount = 'user/delete-account';
  static const String updateCountry = 'user/profile/change-currency-country';
  // ---------------------- Change_Email -----------------------------------
  static const String changeEmailCheckPassword =
      'user/profile/change-email-check-password';
  static const String changeEmailSendCode =
      'user/profile/change-email-send-code';
  static const String changeEmailReSendCode =
      'user/profile/change-email-resend-code';
  static const String changeEmailVerifyCode =
      'user/profile/change-email-verify-code';

  // ---------------------- More -----------------------------------
  static const String faqs = 'get-faqs';
  static const String about = 'about';
  static const String terms = 'terms';
  static const String privacy = 'privacy';
  static const String contactUs = 'send-help-message';
  static const String complain = 'user/complaints/get-complaint-data';
  static const String addComplain = 'user/complaints/send';
  static const String complainDetails = 'user/complaints/';
  static const String logOut = 'user/sign-out';
}
