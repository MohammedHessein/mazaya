import 'package:multiple_result/multiple_result.dart';
import 'package:mazaya/src/core/error/failure.dart';
import '../entities/base_name_and_id_entity.dart';
import '../usecases/get_base_id_and_name_usecase.dart';
import '../usecases/base_crud.dart';

abstract class BaseRepository {
  Future<Result<List<T>, Failure>> getBaseIdAndNameEntity<T extends BaseEntity>(
    GetBaseEntityParams? param,
  );

  Future<Result<T, Failure>> crudCall<T>(CrudBaseParams params);
}
