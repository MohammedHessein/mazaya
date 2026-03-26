import 'package:flutter/material.dart';
import '../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../core/extensions/base_state.dart';
import '../../handling_views/error_view.dart';
import '../../custom_loading.dart';

class StatusBuilder<T> extends StatelessWidget {
  final AsyncState<T> data;
  final String? errorMessage;
  final Widget Function(T data, BuildContext context) onSuccess;
  final Widget Function()? onFail;
  final Widget Function()? onLoading;

  const StatusBuilder({
    super.key,
    required this.data,
    this.errorMessage,
    required this.onSuccess,
    this.onFail,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return data.status.when(
      onSuccess: () => onSuccess(data.data, context),
      onLoading: () =>
          onLoading?.call() ?? CustomLoading.showLoadingView(),
      onError: () =>
          onFail?.call() ??
          ErrorView(error: errorMessage ?? data.errorMessage ?? 'حدث خطأ'),
      onLoadingMore: () => onSuccess(data.data, context),
      onInitial: () => onSuccess(data.data, context),
    );
  }
}
