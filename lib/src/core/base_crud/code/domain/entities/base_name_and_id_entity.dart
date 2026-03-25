part of '../base_domain_imports.dart';

String getBaseIdAndNameEntityApi<T extends BaseEntity>(
  GetBaseEntityParams? params,
) {
  final Map<Type, String Function(GetBaseEntityParams?)> apiPaths = {
    CountryEntity: (_) => "countries", //Api Key For Countries
  };
  if (T == BaseEntity) {
    throw UnsupportedError(
      'Cannot call API for the base class BaseIdAndNameEntity. Use a concrete subclass instead.',
    );
  }

  final pathBuilder = apiPaths[T];
  if (pathBuilder == null) {
    log('Type passed: $T');
    throw UnsupportedError(
      'API path for type $T is not defined in apiPaths map.',
    );
  }
  return pathBuilder(params);
}

abstract class BaseEntity extends Equatable {
  final int id;

  const BaseEntity({required this.id});

  static final Map<Type, Function> _fromJsonFactories = {
    CountryEntity: (json) => CountryEntity.fromJson(json),
  };

  static T fromJson<T extends BaseEntity>(Map<String, dynamic> json) {
    final fromJsonFactory = _fromJsonFactories[T];

    if (fromJsonFactory != null) {
      return fromJsonFactory(json) as T;
    } else {
      log('Type passed: $T');
      throw UnsupportedError(
        'Type $T is not supported. Please add it to the _fromJsonFactories map in BaseEntity and perform a full app restart.',
      );
    }
  }

  Map<String, dynamic> toJson() => {'id': id};

  @override
  List<Object?> get props => [id];

  BaseEntity copyWith({int? id});
}

abstract class BaseIdAndNameEntity extends BaseEntity {
  final String name;

  const BaseIdAndNameEntity({required super.id, required this.name});

  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseIdAndNameEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  List<Object> get props => [id, name];

  @override
  BaseIdAndNameEntity copyWith({int? id, String? name});
}
