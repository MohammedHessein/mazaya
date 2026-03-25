 import '../../config/language/locale_keys.g.dart';
 
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

  static String? validatePassword(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : "${LocaleKeys.filedValidation} $fieldTitle";
    } else if (!RegExp(
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@#$%^&*()_+=\[\]{};:,.<>?/\\|`~!-]).{8,16}$",
    ).hasMatch(value!)) {
      return LocaleKeys.passSymbols;
    } else if (value.length > 16) {
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
