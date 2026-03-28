import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';

class CategoryEntity extends BaseIdAndNameEntity {
  const CategoryEntity({
    required super.id,
    required super.name,
  });

  @override
  CategoryEntity copyWith({int? id, String? name}) => CategoryEntity(
    id: id ?? this.id,
    name: name ?? this.name,
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
    id: json["id"],
    name: json["name"],
  );
}
