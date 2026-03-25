import '../base_domain_imports.dart';

class CountryEntity extends BaseIdAndNameEntity {
  final String key;
  final String flag;

  const CountryEntity({
    required super.id,
    required super.name,
    required this.key,
    required this.flag,
  });

  @override
  CountryEntity copyWith({int? id, String? name, String? key, String? flag}) =>
      CountryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        key: key ?? this.key,
        flag: flag ?? this.flag,
      );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "key": key,
    "flag": flag,
  };

  factory CountryEntity.fromJson(Map<String, dynamic> json) => CountryEntity(
    id: json["id"],
    name: json["name"],
    key: json["key"],
    flag: json["flag"],
  );
}

