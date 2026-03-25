 
import '../../../config/res/config_imports.dart';

class BaseModel<T> {
  final String message;
  final T data;
  final String key;

  BaseModel({required this.message, required this.data, required this.key});

  factory BaseModel.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic json)? jsonToModel,
  }) {
    return BaseModel(
      message: json['msg'] ?? ConstantManager.emptyText,
      key: json['key'] ?? ConstantManager.emptyText,
      data: jsonToModel != null
          ? json['data'] == null
                ? jsonToModel({'msg': json['msg'] ?? json['message'] ?? ""})
                : jsonToModel(json)
          : json['key'] ?? json['msg'] ?? '',
    );
  }
}
