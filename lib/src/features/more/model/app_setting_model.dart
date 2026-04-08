import 'package:equatable/equatable.dart';

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
      whatsappPhone: data['whatsapp_phone'],
      mobile: data['mobile'],
      websiteLink: data['website_link'],
      facebookLink: data['facebook_link'],
      instagramLink: data['instagram_link'],
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
