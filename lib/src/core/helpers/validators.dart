import 'package:mazaya/src/config/language/locale_keys.g.dart';

class Validators {
  static String? validateEmpty(String? value, {String? fieldTitle}) {
    if (value == null || value.isEmpty) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    }

    return null;
  }

  static String? validateMessage(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (value!.length < 5) {
      return LocaleKeys.messageLengthValidation;
    } else if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    }
    return null;
  }

  static String? validateName(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (value.length < 3) {
      return LocaleKeys.fullNameShouldBeThreeAtLeast;
    }
    return null;
  }

  static String? validateEmail(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.["
      r'a-zA-Z]+',
    ).hasMatch(value)) {
      return LocaleKeys.mailValidation;
    }
    return null;
  }

  static String? validateNewPassword(
    String? value,
    String? currentPassword, {
    String? fieldTitle,
  }) {
    final validation = validatePassword(value, fieldTitle: fieldTitle);
    if (validation != null) return validation;
    if (value == currentPassword) {
      return 'لا يمكن أن تكون كلمة المرور الجديدة هي نفسها كلمة المرور الحالية';
    }
    return null;
  }

  static String? validatePassword(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : "${LocaleKeys.filedValidation} $fieldTitle";
    } else if (value!.length < 6) {
      return LocaleKeys
          .passValidation; // Assuming this points to a 'min length' message
    } else if (value.length > 32) {
      return LocaleKeys.passValidation;
    } else if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    }
    return null;
  }

  static String? validatePasswordConfirm(
    String? value,
    String? pass, {
    String? fieldTitle,
  }) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : "${LocaleKeys.filedValidation} $fieldTitle";
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (value != pass) {
      return LocaleKeys.confirmValidation;
    }
    return null;
  }

  static String? validatePhone(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
      return LocaleKeys.phoneValidation;
    }
    return null;
  }

  static String? noValidate(String value) {
    if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    } else {
      return null;
    }
  }

  static String? validateDropDown<T>(T? value, {String? fieldTitle}) {
    if (value == null) {
      return fieldTitle != null
          ? '${LocaleKeys.please} $fieldTitle'
          : LocaleKeys.fillField;
    } else {
      return null;
    }
  }
}
