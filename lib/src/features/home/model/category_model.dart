import 'package:equatable/equatable.dart';
import 'package:mazaya/src/core/helpers/mapping_helpers.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: MappingHelpers.toInt(json['id']),
      name: MappingHelpers.toStringSafe(json['name'] ?? json['title']),
      image: MappingHelpers.toStringSafe(json['image']),
    );
  }
  factory CategoryModel.initial() {
    return const CategoryModel(id: 0, name: '', image: '');
  }
  @override
  List<Object?> get props => [id, name, image];
}
