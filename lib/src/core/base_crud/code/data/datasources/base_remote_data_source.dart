part of '../base_data_imports.dart';

abstract class BaseRemoteDataSource {
  Future<List<T>> getData<T extends BaseEntity>(GetBaseEntityParams? param);

  Future<T> crudCall<T>(CrudBaseParams param);
}

@LazySingleton(as: BaseRemoteDataSource)
class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  final NetworkService dioService;

  BaseRemoteDataSourceImpl({required this.dioService});

  @override
  Future<List<T>> getData<T extends BaseEntity>(
    GetBaseEntityParams? param,
  ) async {
    return (await dioService.callApi<List<T>>(
      NetworkRequest(
        path: getBaseIdAndNameEntityApi<T>(param),
        queryParameters: param?.toJson(),
        method: RequestMethod.get,
      ),
      mapper: (json) {
        if (param?.mapper != null) return param!.mapper!<List<T>>(json);
        final list = (json is Map && json.containsKey('data'))
            ? json['data'] as List
            : json as List;
        return List<T>.from(list.map((x) => BaseEntity.fromJson<T>(x)));
      },
    )).data;
  }
  // @override
  // Future<List<T>> getData<T extends BaseEntity>(
  //     GetBaseEntityParams? param) async {
  //   return (await dioService.callApi<List<T>>(
  //     NetworkRequest(
  //         path: getBaseIdAndNameEntityApi<T>(param),
  //         queryParameters: param?.toJson(),
  //         method: RequestMethod.get),
  //     mapper: (json) => param?.mapper != null
  //         ? param!.mapper!<List<T>>(json)
  //         : List<T>.from(
  //             json.map((x) => baseIdAndNameEntityFromJson<T>(x)),
  //           ),
  //   ))
  //       .data;
  //

  @override
  Future<T> crudCall<T>(CrudBaseParams param) async {
    return (await dioService.callApi<T>(
      NetworkRequest(
        headers: {
          // if (param.removeContentLength) 'Remove-Content-Length': true,
        },
        path: param.api,
        method: param.httpRequestType.requestMethod,
        body: param.body,
        isFormData: param.isFromData,
        queryParameters: param.queryParameters,
        onSendProgress: param.onSendProgress,
      ),
      mapper: (json) => param.mapper(json),
    )).data;
  }
}
