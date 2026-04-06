import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';

part 'get_base_name_and_id_state.dart';

class GetBaseEntityCubit<T extends BaseEntity>
    extends Cubit<GetBaseEntityState<T>> {
  GetBaseEntityCubit()
    : super(GetBaseEntityState(dataState: Async<List<T>>.initial())) {
    getBaseEntityseCase = injector();
  }

  late final GetBaseEntityUseCase getBaseEntityseCase;

  Future<void> fGetBaseNameAndId({int? id, bool idIsRequired = false}) async {
    log(T.runtimeType.toString());
    if (idIsRequired && id == null) {
      return;
    }
    emit(state.copyWith(data: Async<List<T>>.loading()));
    final result = await getBaseEntityseCase<T>(
      GetBaseEntityParams(id: id, paramsType: ParamsType.path),
    );
    if (isClosed) return;
    if (isClosed) return;
    result.when(
      (data) {
        if (isClosed) return;
        emit(state.copyWith(data: Async<List<T>>.success(data)));
      },
      (failure) {
        if (isClosed) return;
        emit(state.copyWith(data: Async<List<T>>.failure(failure)));
      },
    );
  }

  Future<void> fGetBaseNameAndIdWithQuery({
    required GetBaseEntityParams params,
  }) async {
    log(T.runtimeType.toString());
    emit(state.copyWith(data: Async<List<T>>.loading()));
    final result = await getBaseEntityseCase<T>(params);
    if (isClosed) return;
    if (isClosed) return;
    result.when(
      (data) {
        if (isClosed) return;
        emit(state.copyWith(data: Async<List<T>>.success(data)));
      },
      (failure) {
        if (isClosed) return;
        emit(state.copyWith(data: Async<List<T>>.failure(failure)));
      },
    );
  }
}
