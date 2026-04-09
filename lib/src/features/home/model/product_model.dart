import 'package:equatable/equatable.dart';
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
    int toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      return int.tryParse(value.toString()) ?? 0;
    }

    return ProductModel(
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
      isActive: json['is_active'] == null ? true : (json['is_active'] is bool ? json['is_active'] : (json['is_active'].toString() == '1' || json['is_active'].toString().toLowerCase() == 'true')),
      isUsed: json['is_used'] ?? false,
      packageNames: json['package_name'] is List
          ? (json['package_name'] as List).map((e) => e.toString()).toList()
          : (json['package_name'] != null ? [json['package_name'].toString()] : null),
      packageIds: json['package_id'] is List
          ? (json['package_id'] as List).map((e) => toInt(e)).toList()
          : (json['package_id'] != null ? [toInt(json['package_id'])] : null),
      qrPayload: json['qr_payload'],
      vendorLink: json['vendor_link'],
      vendorDescription: json['vendor_description'],
      vendorLat: json['vendor_lat']?.toString(),
      vendorLng: json['vendor_lng']?.toString(),
      createdAt: json['created_at'],
      locationId: toInt(json['location_id']),
      locationName: json['location_name'],
      locationParentId: toInt(json['location_parent_id']),
      locationParentName: json['location_parent_name'],
      locationGrandparentId: toInt(json['location_grandparent_id']),
      locationGrandparentName: json['location_grandparent_name'],
      vendorCouponsRemaining: toInt(json['vendor_coupons_remaining']),
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
