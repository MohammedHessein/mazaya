import 'package:equatable/equatable.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

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
      productId: MappingHelpers.toInt(json['product_id']),
      productName: MappingHelpers.toStringSafe(json['product_name']),
      discount: MappingHelpers.toStringSafe(json['discount']),
      discountType: MappingHelpers.toStringSafe(json['discount_type']),
      categoryId: MappingHelpers.toInt(json['category_id']),
      categoryName: MappingHelpers.toStringSafe(json['category_name']),
      message: MappingHelpers.toStringSafe(json['message']),
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
