import 'package:equatable/equatable.dart';

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
    final rawTitle = json['title'] ?? json['name'];

    final title = (rawTitle is String ? rawTitle : '').trim();

    return CategoryModel(
      id: json['id'] ?? 0,
      name: title,
      image: json['image'] ?? '',
    );
  }
  factory CategoryModel.initial() {
    return const CategoryModel(id: 0, name: '', image: '');
  }
  @override
  List<Object?> get props => [id, name, image];
}
