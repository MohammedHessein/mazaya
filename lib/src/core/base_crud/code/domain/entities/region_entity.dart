import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';

class RegionEntity extends BaseIdAndNameEntity {
  const RegionEntity({
    required super.id,
    required super.name,
  });

  @override
  RegionEntity copyWith({int? id, String? name}) => RegionEntity(
    id: id ?? this.id,
    name: name ?? this.name,
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  factory RegionEntity.fromJson(Map<String, dynamic> json) => RegionEntity(
    id: json["id"],
    name: json["name"],
  );
}
