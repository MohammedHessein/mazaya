import 'package:mazaya/src/config/res/config_imports.dart';

class BaseModel<T> {
  final String message;
  final T data;
  final String key;

  BaseModel({required this.message, required this.data, required this.key});

  factory BaseModel.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic json)? jsonToModel,
  }) {
    final msg = json['message'] ?? json['msg'] ?? ConstantManager.emptyText;
    final status = json['status'] ?? json['key'] ?? ConstantManager.emptyText;

    return BaseModel(
      message: msg,
      key: status,
      data: jsonToModel != null
          ? json['data'] == null
                ? jsonToModel({
                    'msg': msg,
                    'message': msg,
                    'key': status,
                    'status': status,
                  })
                : jsonToModel(json)
          : (json['data'] ?? status),
    );
  }
}
