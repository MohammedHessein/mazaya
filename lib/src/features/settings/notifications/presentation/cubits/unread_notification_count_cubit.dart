import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/res/config_imports.dart';
import '../../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../../core/network/api_endpoints.dart';
 

@lazySingleton
class UnreadNotificationCountCubit extends Cubit<int> {
  UnreadNotificationCountCubit() : super(0);

  late final BaseCrudUseCase _baseCrudUseCase = injector();

  Future<void> fetchUnreadCount() async {
    final result = await _baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.unReadNotifications,
        httpRequestType: HttpRequestType.get,
        mapper: (json) => json['data']['count'] as int? ?? 0,
      ),
    );
    result.when((count) => emit(count), (failure) => emit(0));
  }

  void decrementCount() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void resetCount() {
    emit(0);
  }

  void setCount(int count) {
    emit(count);
  }

  @override
  void emit(int state) {
    if (isClosed) return;
    super.emit(state);
  }
}
