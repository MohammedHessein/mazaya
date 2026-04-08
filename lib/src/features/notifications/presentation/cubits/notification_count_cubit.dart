part of '../imports/view_imports.dart';

@lazySingleton
class NotificationCountCubit extends Cubit<int> {
  NotificationCountCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void reset() {
    emit(0);
  }

  void setCount(int count) {
    emit(count);
  }
}
