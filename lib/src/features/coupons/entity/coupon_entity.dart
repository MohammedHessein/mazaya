import 'package:equatable/equatable.dart';
import 'package:mazaya/src/config/res/config_imports.dart';

class CouponEntity extends Equatable {
  final int id;
  final String name;
  final String? shortDescription;
  final String? description;
  final String productImage;
  final dynamic discount;
  final String? discountType;
  final String? sku;
  final int vendorId;
  final String? vendorName;
  final String? vendorImage;
  final int categoryId;
  final String? categoryName;
  final bool isFav;
  final String? qrPayload;
  final bool? isUsed;
  final double? lat;
  final double? lng;
  final String? vendorDescription;
  final String? vendorLink;
  final List<int>? packageIds;
  final List<String>? packageNames;
  final int? locationId;
  final String? locationName;
  final int? locationParentId;
  final String? locationParentName;
  final int? locationGrandparentId;
  final String? locationGrandparentName;
  final String? createdAt;
  final bool isActive;
  final int? vendorCouponsRemaining;

  const CouponEntity({
    required this.id,
    required this.name,
    this.shortDescription,
    this.description,
    required this.productImage,
    this.discount,
    this.discountType,
    this.sku,
    this.vendorId = 0,
    this.vendorName,
    this.vendorImage,
    required this.categoryId,
    this.categoryName,
    this.isFav = false,
    this.qrPayload,
    this.isUsed,
    this.lat,
    this.lng,
    this.vendorDescription,
    this.vendorLink,
    this.packageIds,
    this.packageNames,
    this.locationId,
    this.locationName,
    this.locationParentId,
    this.locationParentName,
    this.locationGrandparentId,
    this.locationGrandparentName,
    this.createdAt,
    this.isActive = true,
    this.vendorCouponsRemaining,
  });

  const CouponEntity.empty()
    : id = 0,
      name = '',
      shortDescription = '',
      description = '',
      productImage = '',
      discount = 0.0,
      discountType = '',
      sku = '',
      vendorId = 0,
      vendorName = '',
      vendorImage = '',
      categoryId = 0,
      categoryName = '',
      isFav = false,
      isUsed = false,
      qrPayload = '',
      lat = null,
      lng = null,
      vendorDescription = null,
      vendorLink = null,
      packageIds = null,
      packageNames = null,
      locationId = null,
      locationName = null,
      locationParentId = null,
      locationParentName = null,
      locationGrandparentId = null,
      locationGrandparentName = null,
      createdAt = null,
      isActive = true,
      vendorCouponsRemaining = null;

  factory CouponEntity.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      return int.tryParse(value.toString()) ?? 0;
    }

    return CouponEntity(
      id: toInt(json['id']),
      name: json['name'] ?? json['title'] ?? '',
      shortDescription: json['short_description'],
      description: json['description'],
      productImage: json['product_image'] ?? '',
      discount: json['discount'],
      discountType: json['discount_type'],
      sku: json['sku'],
      vendorId: toInt(json['vendor_id']),
      vendorName: json['vendor_name'],
      vendorImage: json['vendor_image'],
      categoryId: toInt(json['category_id']),
      categoryName: json['category_name'],
      isFav: json['is_fav'] ?? false,
      qrPayload: json['qr_payload'],
      isUsed: json['is_used'] ?? false,
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : json['vendor_lat'] != null ? double.tryParse(json['vendor_lat'].toString()) : json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      lng: json['lng'] != null ? double.tryParse(json['lng'].toString()) : json['vendor_lng'] != null ? double.tryParse(json['vendor_lng'].toString()) : json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
      vendorDescription: json['vendor_description'],
      vendorLink: json['vendor_link'],
      packageIds: json['package_id'] is List
          ? (json['package_id'] as List).map((e) => toInt(e)).toList()
          : (json['package_id'] != null ? [toInt(json['package_id'])] : null),
      packageNames: json['package_name'] is List
          ? (json['package_name'] as List).map((e) => e.toString()).toList()
          : (json['package_name'] != null ? [json['package_name'].toString()] : null),
      locationId: toInt(json['location_id']),
      locationName: json['location_name'],
      locationParentId: toInt(json['location_parent_id']),
      locationParentName: json['location_parent_name'],
      locationGrandparentId: toInt(json['location_grandparent_id']),
      locationGrandparentName: json['location_grandparent_name'],
      createdAt: json['created_at'],
      isActive: json['is_active'] == null ? true : (json['is_active'] is bool ? json['is_active'] : (json['is_active'].toString() == '1' || json['is_active'].toString().toLowerCase() == 'true')),
      vendorCouponsRemaining: json['vendor_coupons_remaining'],
    );
  }

  factory CouponEntity.initial() {
    return const CouponEntity(
      id: 0,
      name: SkeltonizerManager.short,
      shortDescription: SkeltonizerManager.medium,
      description: SkeltonizerManager.medium,
      productImage: '',
      discount: 0.0,
      discountType: '',
      sku: '',
      categoryId: 0,
    );
  }

  CouponEntity copyWith({
    int? id,
    String? name,
    String? shortDescription,
    String? description,
    String? productImage,
    dynamic discount,
    String? discountType,
    String? sku,
    int? vendorId,
    String? vendorName,
    String? vendorImage,
    int? categoryId,
    String? categoryName,
    bool? isFav,
    String? qrPayload,
    bool? isUsed,
    double? lat,
    double? lng,
    String? vendorDescription,
    String? vendorLink,
    List<int>? packageIds,
    List<String>? packageNames,
    int? locationId,
    String? locationName,
    int? locationParentId,
    String? locationParentName,
    int? locationGrandparentId,
    String? locationGrandparentName,
    String? createdAt,
    bool? isActive,
    int? vendorCouponsRemaining,
  }) {
    return CouponEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      productImage: productImage ?? this.productImage,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      sku: sku ?? this.sku,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      vendorImage: vendorImage ?? this.vendorImage,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      isFav: isFav ?? this.isFav,
      qrPayload: qrPayload ?? this.qrPayload,
      isUsed: isUsed ?? this.isUsed,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      vendorDescription: vendorDescription ?? this.vendorDescription,
      vendorLink: vendorLink ?? this.vendorLink,
      packageIds: packageIds ?? this.packageIds,
      packageNames: packageNames ?? this.packageNames,
      locationId: locationId ?? this.locationId,
      locationName: locationName ?? this.locationName,
      locationParentId: locationParentId ?? this.locationParentId,
      locationParentName: locationParentName ?? this.locationParentName,
      locationGrandparentId: locationGrandparentId ?? this.locationGrandparentId,
      locationGrandparentName: locationGrandparentName ?? this.locationGrandparentName,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      vendorCouponsRemaining: vendorCouponsRemaining ?? this.vendorCouponsRemaining,
    );
  }

  String get fullLocationName {
    final List<String> parts = [];
    if (locationGrandparentName != null &&
        locationGrandparentName!.isNotEmpty) {
      parts.add(locationGrandparentName!);
    }
    if (locationParentName != null && locationParentName!.isNotEmpty) {
      parts.add(locationParentName!);
    }
    if (locationName != null && locationName!.isNotEmpty) {
      parts.add(locationName!);
    }
    return parts.join(', ');
  }

  bool get hasValidLocation =>
      lat != null && lng != null && lat != 0.0 && lng != 0.0;

  @override
  List<Object?> get props => [
    id,
    name,
    shortDescription,
    description,
    productImage,
    discount,
    discountType,
    sku,
    vendorId,
    vendorName,
    vendorImage,
    categoryId,
    categoryName,
    isFav,
    qrPayload,
    isUsed,
    lat,
    lng,
    vendorDescription,
    vendorLink,
    packageIds,
    packageNames,
    locationId,
    locationName,
    locationParentId,
    locationParentName,
    locationGrandparentId,
    locationGrandparentName,
    createdAt,
    isActive,
    vendorCouponsRemaining,
  ];
}
