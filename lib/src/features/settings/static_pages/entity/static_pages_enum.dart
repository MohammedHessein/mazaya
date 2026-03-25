import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/network/api_endpoints.dart';

enum StaticPageTypeEnum {
  aboutRita,
  termsAndConditions,
  usagePolicy;

  String get title {
    switch (this) {
      case StaticPageTypeEnum.aboutRita:
        return LocaleKeys.whoUs;
      case StaticPageTypeEnum.termsAndConditions:
        return LocaleKeys.terms;
      case StaticPageTypeEnum.usagePolicy:
        return LocaleKeys.policy;
    }
  }

  String get apiEndpoint {
    switch (this) {
      case StaticPageTypeEnum.aboutRita:
        return ApiConstants.about;
      case StaticPageTypeEnum.termsAndConditions:
        return ApiConstants.terms;
      case StaticPageTypeEnum.usagePolicy:
        return ApiConstants.privacy;
    }
  }
}
