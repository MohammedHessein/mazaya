import 'package:equatable/equatable.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

class AppSettingModel extends Equatable {
  final String? whatsappPhone;
  final String? mobile;
  final String? websiteLink;
  final String? facebookLink;
  final String? instagramLink;

  const AppSettingModel({
    this.whatsappPhone,
    this.mobile,
    this.websiteLink,
    this.facebookLink,
    this.instagramLink,
  });

  factory AppSettingModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return AppSettingModel(
      whatsappPhone: MappingHelpers.toStringSafe(data['whatsapp_phone']),
      mobile: MappingHelpers.toStringSafe(data['mobile']),
      websiteLink: MappingHelpers.toStringSafe(data['website_link']),
      facebookLink: MappingHelpers.toStringSafe(data['facebook_link']),
      instagramLink: MappingHelpers.toStringSafe(data['instagram_link']),
    );
  }

  @override
  List<Object?> get props => [
        whatsappPhone,
        mobile,
        websiteLink,
        facebookLink,
        instagramLink,
      ];
}
