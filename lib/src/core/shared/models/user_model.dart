class UserModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String? firstName;
  final String? lastName;
  final String? personalNumber;
  final String? lat;
  final String? lng;
  final String? countryCode;
  final String? emailVerifiedAt;
  final String photoProfile;
  final String status;
  final String? address;
  final String? poBox;
  final String? nationalId;
  final int? locationId;
  final String? locationName;
  final int? locationParentId;
  final String? locationParentName;
  final int? locationGrandparentId;
  final String? locationGrandparentName;
  final String? userPackageName;
  final String? memberType;
  final String? userPackageImage;
  final int? userPackageCouponsLimit;
  final int? userPackageUsedCoupons;
  final int? userPackageRemainingCoupons;
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
    this.firstName,
    this.lastName,
    this.personalNumber,
    this.lat,
    this.lng,
    this.countryCode,
    this.emailVerifiedAt,
    required this.photoProfile,
    required this.status,
    this.address,
    this.poBox,
    this.nationalId,
    this.locationId,
    this.locationName,
    this.locationParentId,
    this.locationParentName,
    this.locationGrandparentId,
    this.locationGrandparentName,
    this.userPackageName,
    this.memberType,
    this.userPackageImage,
    this.userPackageCouponsLimit,
    this.userPackageUsedCoupons,
    this.userPackageRemainingCoupons,
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
    firstName: null,
    lastName: null,
    personalNumber: null,
    lat: null,
    lng: null,
    countryCode: null,
    emailVerifiedAt: null,
    photoProfile: '',
    status: '',
    address: null,
    poBox: null,
    nationalId: null,
    locationId: null,
    locationName: null,
    locationParentId: null,
    locationParentName: null,
    locationGrandparentId: null,
    locationGrandparentName: null,
    userPackageName: null,
    memberType: null,
    userPackageImage: null,
    userPackageCouponsLimit: null,
    userPackageUsedCoupons: null,
    userPackageRemainingCoupons: null,
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
    String? firstName,
    String? lastName,
    String? personalNumber,
    String? lat,
    String? lng,
    String? countryCode,
    String? emailVerifiedAt,
    String? photoProfile,
    String? status,
    String? address,
    String? poBox,
    String? nationalId,
    int? locationId,
    String? locationName,
    int? locationParentId,
    String? locationParentName,
    int? locationGrandparentId,
    String? locationGrandparentName,
    String? userPackageName,
    String? memberType,
    String? userPackageImage,
    int? userPackageCouponsLimit,
    int? userPackageUsedCoupons,
    int? userPackageRemainingCoupons,
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
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      personalNumber: personalNumber ?? this.personalNumber,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      countryCode: countryCode ?? this.countryCode,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      photoProfile: photoProfile ?? this.photoProfile,
      status: status ?? this.status,
      address: address ?? this.address,
      poBox: poBox ?? this.poBox,
      nationalId: nationalId ?? this.nationalId,
      locationId: locationId ?? this.locationId,
      locationName: locationName ?? this.locationName,
      locationParentId: locationParentId ?? this.locationParentId,
      locationParentName: locationParentName ?? this.locationParentName,
      locationGrandparentId:
          locationGrandparentId ?? this.locationGrandparentId,
      locationGrandparentName:
          locationGrandparentName ?? this.locationGrandparentName,
      userPackageName: userPackageName ?? this.userPackageName,
      memberType: memberType ?? this.memberType,
      userPackageImage: userPackageImage ?? this.userPackageImage,
      userPackageCouponsLimit:
          userPackageCouponsLimit ?? this.userPackageCouponsLimit,
      userPackageUsedCoupons:
          userPackageUsedCoupons ?? this.userPackageUsedCoupons,
      userPackageRemainingCoupons:
          userPackageRemainingCoupons ?? this.userPackageRemainingCoupons,
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
      id: _toInt(user['id'] ?? user['userId']) ?? 0,
      name: user['name'] ?? user['fullName'] ?? '',
      email: user['email'] ?? '',
      mobile: (user['mobile'] ?? user['phoneNumber'] ?? '').toString(),
      firstName: (user['first_name'] ?? user['firstName'])?.toString(),
      lastName: (user['last_name'] ?? user['lastName'])?.toString(),
      personalNumber: (user['personalnumber'] ?? user['personal_number'] ?? user['personalNumber'] ?? user['national_id'] ?? user['nationalId'])?.toString(),
      lat: (user['lat'] ?? user['latitude'])?.toString(),
      lng: (user['lng'] ?? user['longitude'])?.toString(),
      countryCode: (user['country_code'] ?? user['countryCode'])?.toString(),
      emailVerifiedAt: (user['email_verified_at'] ?? user['emailVerifiedAt'])?.toString(),
      photoProfile: user['photo_profile'] ?? user['image'] ?? user['photoProfile'] ?? '',
      status: (user['status'] ?? '').toString(),
      address: (user['address'])?.toString(),
      poBox: (user['po_box'] ?? user['poBox'])?.toString(),
      nationalId: (user['national_id'] ?? user['nationalId'] ?? user['personalnumber'] ?? user['personal_number'])?.toString(),
      locationId: _toInt(user['location_id'] ?? user['locationId']),
      locationName: (user['location_name'] ?? user['locationName'] ?? user['city'] ?? '').toString(),
      locationParentId: _toInt(user['location_parent_id'] ?? user['locationParentId']),
      locationParentName: (user['location_parent_name'] ?? user['locationParentName'])?.toString(),
      locationGrandparentId: _toInt(user['location_grandparent_id'] ?? user['locationGrandparentId']),
      locationGrandparentName: (user['location_grandparent_name'] ?? user['locationGrandparentName'])?.toString(),
      userPackageName: user['user_package_name'] ?? user['userPackageName'],
      memberType: user['member_type'] ?? user['memberType'],
      userPackageImage: user['user_package_image'] ?? user['userPackageImage'],
      userPackageCouponsLimit: _toInt(user['user_package_coupons_limit'] ?? user['userPackageCouponsLimit'] ?? package['coupons_limit']),
      userPackageUsedCoupons: _toInt(user['user_package_used_coupons'] ?? user['userPackageUsedCoupons'] ?? package['used_coupons']),
      userPackageRemainingCoupons: _toInt(user['user_package_remaining_coupons'] ?? user['userPackageRemainingCoupons'] ?? package['remaining_coupons']),
      userPackageStartDate: user['user_package_start_date'] ?? user['userPackageStartDate'] ?? package['start_date'],
      userPackageEndDate: user['user_package_end_date'] ?? user['userPackageEndDate'] ?? package['end_date'],
      userPackageIsActive: user['userPackageIsActive'] ?? (package['is_active'] ?? false),
      createdAt: (user['created_at'] ?? user['createdAt'] ?? '').toString(),
      token:
          data['token'] ?? (json.containsKey('token') ? json['token'] : null),
      isExpired:
          data['isExpired'] ??
          (json.containsKey('isExpired') ? json['isExpired'] : null),
      allowNotify: user['allowNotify'] ?? user['allow_notify'] ?? false,
      userType: _toInt(user['userType'] ?? user['user_type']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'mobile': mobile,
    'first_name': firstName,
    'last_name': lastName,
    'personalnumber': personalNumber,
    'lat': lat,
    'lng': lng,
    'country_code': countryCode,
    'email_verified_at': emailVerifiedAt,
    'photo_profile': photoProfile,
    'status': status,
    'address': address,
    'po_box': poBox,
    'national_id': nationalId,
    'location_id': locationId,
    'location_name': locationName,
    'location_parent_id': locationParentId,
    'location_parent_name': locationParentName,
    'location_grandparent_id': locationGrandparentId,
    'location_grandparent_name': locationGrandparentName,
    'user_package_name': userPackageName,
    'member_type': memberType,
    'user_package_image': userPackageImage,
    'user_package_coupons_limit': userPackageCouponsLimit,
    'user_package_used_coupons': userPackageUsedCoupons,
    'user_package_remaining_coupons': userPackageRemainingCoupons,
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
