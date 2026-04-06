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
    );
  }
}
