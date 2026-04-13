import 'package:equatable/equatable.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String? shortDescription;
  final String? description;
  final String productImage;
  final String? discount;
  final String? discountType;
  final String? sku;
  final int vendorId;
  final String? vendorName;
  final String? vendorImage;
  final int categoryId;
  final String? categoryName;
  final bool isFav;
  final bool isActive;
  final bool isUsed;
  final List<String>? packageNames;
  final List<int>? packageIds;
  final String? qrPayload;
  final String? vendorLink;
  final String? vendorDescription;
  final String? vendorLat;
  final String? vendorLng;
  final String? createdAt;
  final int? locationId;
  final String? locationName;
  final int? locationParentId;
  final String? locationParentName;
  final int? locationGrandparentId;
  final String? locationGrandparentName;
  final int? vendorCouponsRemaining;

  const ProductModel({
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
    this.categoryId = 0,
    this.categoryName,
    this.isFav = false,
    this.isActive = true,
    this.isUsed = false,
    this.packageNames,
    this.packageIds,
    this.qrPayload,
    this.vendorLink,
    this.vendorDescription,
    this.vendorLat,
    this.vendorLng,
    this.createdAt,
    this.locationId,
    this.locationName,
    this.locationParentId,
    this.locationParentName,
    this.locationGrandparentId,
    this.locationGrandparentName,
    this.vendorCouponsRemaining,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: MappingHelpers.toInt(json['id']),
      name: MappingHelpers.toStringSafe(json['name'] ?? json['title']),
      shortDescription: MappingHelpers.toStringSafe(json['short_description']),
      description: MappingHelpers.toStringSafe(json['description']),
      productImage: MappingHelpers.toStringSafe(json['product_image']),
      discount: MappingHelpers.toStringSafe(json['discount']),
      discountType: MappingHelpers.toStringSafe(json['discount_type']),
      sku: MappingHelpers.toStringSafe(json['sku']),
      vendorId: MappingHelpers.toInt(json['vendor_id']),
      vendorName: MappingHelpers.toStringSafe(json['vendor_name']),
      vendorImage: MappingHelpers.toStringSafe(json['vendor_image']),
      categoryId: MappingHelpers.toInt(json['category_id']),
      categoryName: MappingHelpers.toStringSafe(json['category_name']),
      isFav: MappingHelpers.toBool(json['is_fav']),
      isActive: MappingHelpers.toBool(json['is_active'] ?? true),
      isUsed: MappingHelpers.toBool(json['is_used']),
      packageNames: json['package_name'] is List
          ? (json['package_name'] as List).map((e) => MappingHelpers.toStringSafe(e)).toList()
          : (json['package_name'] != null ? [MappingHelpers.toStringSafe(json['package_name'])] : null),
      packageIds: json['package_id'] is List
          ? (json['package_id'] as List).map((e) => MappingHelpers.toInt(e)).toList()
          : (json['package_id'] != null ? [MappingHelpers.toInt(json['package_id'])] : null),
      qrPayload: MappingHelpers.toStringSafe(json['qr_payload']),
      vendorLink: MappingHelpers.toStringSafe(json['vendor_link']),
      vendorDescription: MappingHelpers.toStringSafe(json['vendor_description']),
      vendorLat: MappingHelpers.toStringSafe(json['vendor_lat']),
      vendorLng: MappingHelpers.toStringSafe(json['vendor_lng']),
      createdAt: MappingHelpers.toStringSafe(json['created_at']),
      locationId: MappingHelpers.toInt(json['location_id']),
      locationName: MappingHelpers.toStringSafe(json['location_name']),
      locationParentId: MappingHelpers.toInt(json['location_parent_id']),
      locationParentName: MappingHelpers.toStringSafe(json['location_parent_name']),
      locationGrandparentId: MappingHelpers.toInt(json['location_grandparent_id']),
      locationGrandparentName: MappingHelpers.toStringSafe(json['location_grandparent_name']),
      vendorCouponsRemaining: MappingHelpers.toInt(json['vendor_coupons_remaining']),
    );
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? shortDescription,
    String? description,
    String? productImage,
    String? discount,
    String? discountType,
    String? sku,
    int? vendorId,
    String? vendorName,
    String? vendorImage,
    int? categoryId,
    String? categoryName,
    bool? isFav,
    bool? isActive,
    bool? isUsed,
    List<String>? packageNames,
    List<int>? packageIds,
    String? qrPayload,
    String? vendorLink,
    String? vendorDescription,
    String? vendorLat,
    String? vendorLng,
    String? createdAt,
    int? locationId,
    String? locationName,
    int? locationParentId,
    String? locationParentName,
    int? locationGrandparentId,
    String? locationGrandparentName,
    int? vendorCouponsRemaining,
  }) {
    return ProductModel(
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
      isActive: isActive ?? this.isActive,
      isUsed: isUsed ?? this.isUsed,
      packageNames: packageNames ?? this.packageNames,
      packageIds: packageIds ?? this.packageIds,
      qrPayload: qrPayload ?? this.qrPayload,
      vendorLink: vendorLink ?? this.vendorLink,
      vendorDescription: vendorDescription ?? this.vendorDescription,
      vendorLat: vendorLat ?? this.vendorLat,
      vendorLng: vendorLng ?? this.vendorLng,
      createdAt: createdAt ?? this.createdAt,
      locationId: locationId ?? this.locationId,
      locationName: locationName ?? this.locationName,
      locationParentId: locationParentId ?? this.locationParentId,
      locationParentName: locationParentName ?? this.locationParentName,
      locationGrandparentId: locationGrandparentId ?? this.locationGrandparentId,
      locationGrandparentName: locationGrandparentName ?? this.locationGrandparentName,
      vendorCouponsRemaining: vendorCouponsRemaining ?? this.vendorCouponsRemaining,
    );
  }

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
    categoryName,
    isFav,
    isActive,
    isUsed,
    packageNames,
    packageIds,
    qrPayload,
    vendorLink,
    vendorDescription,
    vendorLat,
    vendorLng,
    createdAt,
    locationId,
    locationName,
    locationParentId,
    locationParentName,
    locationGrandparentId,
    locationGrandparentName,
    vendorCouponsRemaining,
  ];

  CouponEntity toCouponEntity() {
    return CouponEntity(
      id: id,
      name: name,
      shortDescription: shortDescription,
      description: description,
      productImage: productImage,
      discount: discount,
      discountType: discountType,
      sku: sku,
      vendorId: vendorId,
      vendorName: vendorName,
      vendorImage: vendorImage,
      categoryId: categoryId,
      categoryName: categoryName,
      isFav: isFav,
      isActive: isActive,
      isUsed: isUsed,
      packageNames: packageNames,
      packageIds: packageIds,
      qrPayload: qrPayload,
      vendorLink: vendorLink,
      vendorDescription: vendorDescription,
      lat: vendorLat != null ? double.tryParse(vendorLat!) : null,
      lng: vendorLng != null ? double.tryParse(vendorLng!) : null,
      createdAt: createdAt,
      locationId: locationId,
      locationName: locationName,
      locationParentId: locationParentId,
      locationParentName: locationParentName,
      locationGrandparentId: locationGrandparentId,
      locationGrandparentName: locationGrandparentName,
      vendorCouponsRemaining: vendorCouponsRemaining,
    );
  }
}
