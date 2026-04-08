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
    this.categoryId = 0,
    this.categoryName,
    this.isFav = false,
    this.qrPayload,
    this.isUsed,
    this.lat,
    this.lng,
    this.vendorDescription,
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
      vendorDescription = null;

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
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      lng: json['lng'] != null ? double.tryParse(json['lng'].toString()) : json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
      vendorDescription: json['vendor_description'],
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
    categoryId,
    categoryName,
    isFav,
    qrPayload,
    isUsed,
    lat,
    lng,
    vendorDescription,
  ];
}
