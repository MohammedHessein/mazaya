class UserModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String? countryCode;
  final String? emailVerifiedAt;
  final String photoProfile;
  final String status;
  final String? address;
  final int? locationId;
  final String? locationName;
  final String? userPackageName;
  final String? memberType;
  final String? userPackageImage;
  final int? userPackageCouponsLimit;
  final int? userPackageUsedCoupons;
  final String? userPackageStartDate;
  final String? userPackageEndDate;
  final bool userPackageIsActive;
  final String createdAt;
  final String? token;
  final bool? isExpired;
  final bool allowNotify; // Legacy field
  final int userType; // Legacy field

  // Compatibility getters
  String get fullName => name;
  String get phoneNumber => mobile;
  String get image => photoProfile;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    this.countryCode,
    this.emailVerifiedAt,
    required this.photoProfile,
    required this.status,
    this.address,
    this.locationId,
    this.locationName,
    this.userPackageName,
    this.memberType,
    this.userPackageImage,
    this.userPackageCouponsLimit,
    this.userPackageUsedCoupons,
    this.userPackageStartDate,
    this.userPackageEndDate,
    required this.userPackageIsActive,
    required this.createdAt,
    this.token,
    this.isExpired,
    this.allowNotify = false,
    this.userType = 0,
  });

  factory UserModel.initial() => UserModel(
    id: 0,
    name: '',
    email: '',
    mobile: '',
    countryCode: null,
    emailVerifiedAt: null,
    photoProfile: '',
    status: '',
    address: null,
    locationId: null,
    locationName: null,
    userPackageName: null,
    memberType: null,
    userPackageImage: null,
    userPackageCouponsLimit: null,
    userPackageUsedCoupons: null,
    userPackageStartDate: null,
    userPackageEndDate: null,
    userPackageIsActive: false,
    createdAt: '',
    token: '',
    isExpired: false,
    allowNotify: false,
    userType: 0,
  );

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? mobile,
    String? countryCode,
    String? emailVerifiedAt,
    String? photoProfile,
    String? status,
    String? address,
    int? locationId,
    String? locationName,
    String? userPackageName,
    String? memberType,
    String? userPackageImage,
    int? userPackageCouponsLimit,
    int? userPackageUsedCoupons,
    String? userPackageStartDate,
    String? userPackageEndDate,
    bool? userPackageIsActive,
    String? createdAt,
    String? token,
    bool? isExpired,
    bool? allowNotify,
    int? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      countryCode: countryCode ?? this.countryCode,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      photoProfile: photoProfile ?? this.photoProfile,
      status: status ?? this.status,
      address: address ?? this.address,
      locationId: locationId ?? this.locationId,
      locationName: locationName ?? this.locationName,
      userPackageName: userPackageName ?? this.userPackageName,
      memberType: memberType ?? this.memberType,
      userPackageImage: userPackageImage ?? this.userPackageImage,
      userPackageCouponsLimit:
          userPackageCouponsLimit ?? this.userPackageCouponsLimit,
      userPackageUsedCoupons:
          userPackageUsedCoupons ?? this.userPackageUsedCoupons,
      userPackageStartDate: userPackageStartDate ?? this.userPackageStartDate,
      userPackageEndDate: userPackageEndDate ?? this.userPackageEndDate,
      userPackageIsActive: userPackageIsActive ?? this.userPackageIsActive,
      createdAt: createdAt ?? this.createdAt,
      token: token ?? this.token,
      isExpired: isExpired ?? this.isExpired,
      allowNotify: allowNotify ?? this.allowNotify,
      userType: userType ?? this.userType,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle nested data if passed full response, otherwise handle the user object directly
    final Map<String, dynamic> data =
        (json.containsKey('data') && json['data'] is Map)
        ? json['data'] as Map<String, dynamic>
        : json;
    final Map<String, dynamic> user =
        (data.containsKey('user') && data['user'] is Map)
        ? data['user'] as Map<String, dynamic>
        : data;

    final Map<String, dynamic> package =
        (user.containsKey('package') && user['package'] is Map)
        ? user['package'] as Map<String, dynamic>
        : {};

    return UserModel(
      id: _toInt(user['id']) ?? 0,
      name: user['name'] ?? user['fullName'] ?? '',
      email: user['email'] ?? '',
      mobile: user['mobile'] ?? user['phoneNumber'] ?? '',
      countryCode: user['country_code'],
      emailVerifiedAt: user['email_verified_at'],
      photoProfile: user['photo_profile'] ?? user['image'] ?? '',
      status: user['status'] ?? '',
      address: user['address'],
      locationId: _toInt(user['location_id']),
      locationName: user['location_name'] ?? user['city'] ?? '',
      userPackageName: user['user_package_name'],
      memberType: user['member_type'],
      userPackageImage: user['user_package_image'],
      userPackageCouponsLimit: _toInt(user['user_package_coupons_limit'] ?? package['coupons_limit']),
      userPackageUsedCoupons: _toInt(user['user_package_used_coupons'] ?? package['used_coupons']),
      userPackageStartDate: user['user_package_start_date'] ?? package['start_date'],
      userPackageEndDate: user['user_package_end_date'] ?? package['end_date'],
      userPackageIsActive: user['userPackageIsActive'] ?? (package['is_active'] ?? false),
      createdAt: user['created_at'] ?? '',
      token:
          data['token'] ?? (json.containsKey('token') ? json['token'] : null),
      isExpired:
          data['isExpired'] ??
          (json.containsKey('isExpired') ? json['isExpired'] : null),
      allowNotify: user['allowNotify'] ?? false,
      userType: _toInt(user['userType']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'mobile': mobile,
    'country_code': countryCode,
    'email_verified_at': emailVerifiedAt,
    'photo_profile': photoProfile,
    'status': status,
    'address': address,
    'location_id': locationId,
    'location_name': locationName,
    'user_package_name': userPackageName,
    'member_type': memberType,
    'user_package_image': userPackageImage,
    'user_package_coupons_limit': userPackageCouponsLimit,
    'user_package_used_coupons': userPackageUsedCoupons,
    'user_package_start_date': userPackageStartDate,
    'user_package_end_date': userPackageEndDate,
    'userPackageIsActive': userPackageIsActive,
    'created_at': createdAt,
    'token': token,
    'isExpired': isExpired,
    'allowNotify': allowNotify,
    'userType': userType,
  };
}
