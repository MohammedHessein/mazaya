import 'package:equatable/equatable.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

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
    return CouponEntity(
      id: MappingHelpers.toInt(json['id']),
      name: MappingHelpers.toStringSafe(json['name'] ?? json['title']),
      shortDescription: MappingHelpers.toStringSafe(json['short_description']),
      description: MappingHelpers.toStringSafe(json['description']),
      productImage: MappingHelpers.toStringSafe(json['product_image']),
      discount: json['discount'],
      discountType: MappingHelpers.toStringSafe(json['discount_type']),
      sku: MappingHelpers.toStringSafe(json['sku']),
      vendorId: MappingHelpers.toInt(json['vendor_id']),
      vendorName: MappingHelpers.toStringSafe(json['vendor_name']),
      vendorImage: MappingHelpers.toStringSafe(json['vendor_image']),
      categoryId: MappingHelpers.toInt(json['category_id']),
      categoryName: MappingHelpers.toStringSafe(json['category_name']),
      isFav: MappingHelpers.toBool(json['is_fav']),
      qrPayload: MappingHelpers.toStringSafe(json['qr_payload']),
      isUsed: MappingHelpers.toBool(json['is_used']),
      lat: MappingHelpers.toDouble(json['lat'] ?? json['vendor_lat'] ?? json['latitude']),
      lng: MappingHelpers.toDouble(json['lng'] ?? json['vendor_lng'] ?? json['longitude']),
      vendorDescription: MappingHelpers.toStringSafe(json['vendor_description']),
      vendorLink: MappingHelpers.toStringSafe(json['vendor_link']),
      packageIds: json['package_id'] is List
          ? (json['package_id'] as List).map((e) => MappingHelpers.toInt(e)).toList()
          : (json['package_id'] != null ? [MappingHelpers.toInt(json['package_id'])] : null),
      packageNames: json['package_name'] is List
          ? (json['package_name'] as List).map((e) => MappingHelpers.toStringSafe(e)).toList()
          : (json['package_name'] != null ? [MappingHelpers.toStringSafe(json['package_name'])] : null),
      locationId: MappingHelpers.toInt(json['location_id']),
      locationName: MappingHelpers.toStringSafe(json['location_name']),
      locationParentId: MappingHelpers.toInt(json['location_parent_id']),
      locationParentName: MappingHelpers.toStringSafe(json['location_parent_name']),
      locationGrandparentId: MappingHelpers.toInt(json['location_grandparent_id']),
      locationGrandparentName: MappingHelpers.toStringSafe(json['location_grandparent_name']),
      createdAt: MappingHelpers.toStringSafe(json['created_at']),
      isActive: MappingHelpers.toBool(json['is_active'] ?? true),
      vendorCouponsRemaining: MappingHelpers.toInt(json['vendor_coupons_remaining']),
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
