import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';

class CityEntity extends BaseIdAndNameEntity {
  const CityEntity({required super.id, required super.name});

  @override
  CityEntity copyWith({int? id, String? name}) =>
      CityEntity(id: id ?? this.id, name: name ?? this.name);

  @override
  Map<String, dynamic> toJson() => {"id": id, "name": name};

  factory CityEntity.fromJson(Map<String, dynamic> json) =>
      CityEntity(id: json["id"], name: json["name"]);
}
