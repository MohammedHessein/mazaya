part of 'get_base_name_and_id_cubit.dart';

class GetBaseEntityState<T extends BaseEntity> extends Equatable {
  const GetBaseEntityState({required this.dataState});
  final Async<List<T>> dataState;

  GetBaseEntityState<T> copyWith({Async<List<T>>? data}) {
    return GetBaseEntityState<T>(dataState: data ?? dataState);
  }

  @override
  List<Object> get props => [dataState];
}
