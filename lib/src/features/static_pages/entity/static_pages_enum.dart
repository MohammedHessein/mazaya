import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';

enum StaticPageTypeEnum {
  termsAndConditions,
  usagePolicy;

  String get title {
    switch (this) {
      case StaticPageTypeEnum.termsAndConditions:
        return LocaleKeys.terms;
      case StaticPageTypeEnum.usagePolicy:
        return LocaleKeys.policy;
    }
  }

  String get apiEndpoint {
    switch (this) {
      case StaticPageTypeEnum.termsAndConditions:
        return ApiConstants.termsAndConditions;
      case StaticPageTypeEnum.usagePolicy:
        return ApiConstants.privacyPolicy;
    }
  }
}
