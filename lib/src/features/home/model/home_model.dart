import 'package:equatable/equatable.dart';
import 'category_model.dart';
import 'product_model.dart';

class SliderModel extends Equatable {
  final int id;
  final String image;
  final String? link;

  const SliderModel({required this.id, required this.image, this.link});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      link: json['link'],
    );
  }

  @override
  List<Object?> get props => [id, image, link];
}

class HomeModel extends Equatable {
  final List<SliderModel> sliders;
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  const HomeModel({
    this.sliders = const [],
    this.categories = const [],
    this.products = const [],
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return HomeModel(
      sliders: (data['sliders'] as List?)
              ?.map((e) => SliderModel.fromJson(e))
              .toList() ??
          [],
      categories: (data['categories'] as List?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
          [],
      products: (data['products'] as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  HomeModel copyWith({
    List<SliderModel>? sliders,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
  }) {
    return HomeModel(
      sliders: sliders ?? this.sliders,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [sliders, categories, products];
}
