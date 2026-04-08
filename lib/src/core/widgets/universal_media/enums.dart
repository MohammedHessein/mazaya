import 'package:flutter/material.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';

enum MediaType { video, svg, image }

enum MediaSource { network, asset }

enum ScaffoldHeaderType { standard, auth, home, profile }

enum MembershipType {
  golden,
  sliver,
  diamond,
  volunteer;

  static MembershipType fromString(String? type) {
    if (type == null) return MembershipType.diamond;
    final lowerType = type.toLowerCase();
    if (lowerType.contains('gold') ||
        lowerType.contains('ذهب') ||
        lowerType.contains('guld')) {
      return MembershipType.golden;
    } else if (lowerType.contains('silver') ||
        lowerType.contains('فض') ||
        lowerType.contains('silv')) {
      return MembershipType.sliver;
    } else if (lowerType.contains('volu') || lowerType.contains('متطوع')) {
      return MembershipType.volunteer;
    }
    return MembershipType.diamond;
  }
}

extension MembershipTypeExtension on MembershipType {
  String get label {
    switch (this) {
      case MembershipType.golden:
        return LocaleKeys.goldMember;
      case MembershipType.sliver:
        return LocaleKeys.silverMember;
      case MembershipType.volunteer:
        return LocaleKeys.volunteerMember;
      case MembershipType.diamond:
        return LocaleKeys.diamondMember;
    }
  }

  String get membershipLabel {
    switch (this) {
      case MembershipType.golden:
        return LocaleKeys.goldMembership;
      case MembershipType.sliver:
        return LocaleKeys.silverMembership;
      case MembershipType.volunteer:
        return LocaleKeys.volunteerMembership;
      case MembershipType.diamond:
        return LocaleKeys.diamondMembership;
    }
  }

  String get shortLabel {
    switch (this) {
      case MembershipType.golden:
        return LocaleKeys.golden;
      case MembershipType.sliver:
        return LocaleKeys.silver;
      case MembershipType.volunteer:
        return LocaleKeys.volunteerPackage;
      case MembershipType.diamond:
        return LocaleKeys.diamond;
    }
  }

  Color backgroundColor(BuildContext context) {
    switch (this) {
      case MembershipType.golden:
        return AppColors.orange.withValues(alpha: 0.1);
      case MembershipType.sliver:
        return AppColors.gray200;
      case MembershipType.volunteer:
        return AppColors.success.withValues(alpha: 0.1);
      case MembershipType.diamond:
        return AppColors.blue100;
    }
  }

  Color textColor(BuildContext context) {
    switch (this) {
      case MembershipType.golden:
        return AppColors.orange;
      case MembershipType.sliver:
        return AppColors.hintText;
      case MembershipType.volunteer:
        return AppColors.success;
      case MembershipType.diamond:
        return AppColors.primary;
    }
  }
}
