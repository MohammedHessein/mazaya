import 'package:equatable/equatable.dart';

class ScanResult extends Equatable {
  final int productId;
  final String productName;
  final String discount;
  final String discountType;
  final int categoryId;
  final String categoryName;
  final String message;

  const ScanResult({
    required this.productId,
    required this.productName,
    required this.discount,
    required this.discountType,
    required this.categoryId,
    required this.categoryName,
    required this.message,
  });

  const ScanResult.empty()
      : productId = 0,
        productName = '',
        discount = '',
        discountType = '',
        categoryId = 0,
        categoryName = '',
        message = '';

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      discount: json['discount']?.toString() ?? '',
      discountType: json['discount_type'] ?? '',
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      message: json['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        discount,
        discountType,
        categoryId,
        categoryName,
        message,
      ];
}
