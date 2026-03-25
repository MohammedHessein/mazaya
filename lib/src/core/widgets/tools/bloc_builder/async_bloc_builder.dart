import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../handling_views/error_view.dart';
import '../../../extensions/base_state.dart';

class AsyncBlocBuilder<B extends StateStreamable<AsyncState<T>>, T>
    extends StatelessWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? skeletonBuilder;
  final Widget Function(BuildContext context, String error)? errorBuilder;
  final bool Function(AsyncState<T> previous, AsyncState<T> current)? buildWhen;

  const AsyncBlocBuilder({
    super.key,
    required this.builder,
    this.skeletonBuilder,
    this.errorBuilder,
    this.buildWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, AsyncState<T>>(
      buildWhen: buildWhen,
      builder: (context, state) {
        switch (state.status) {
          case BaseStatus.initial:
          case BaseStatus.loading:
          case BaseStatus.loadingMore:
            final Widget skeletonChild;
            if (skeletonBuilder != null) {
              skeletonChild = skeletonBuilder!(context);
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
            return Skeletonizer(enabled: true, child: skeletonChild);
          case BaseStatus.error:
            if (errorBuilder != null) {
              return errorBuilder!(context, state.errorMessage ?? '');
            }
            return ErrorView(error: state.errorMessage ?? '');
          case BaseStatus.success:
            return builder(context, state.data);
        }
      },
    );
  }
}

class AsyncSliverBlocBuilder<B extends StateStreamable<AsyncState<T>>, T>
    extends StatelessWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? skeletonBuilder;
  final Widget Function(BuildContext context, String error)? errorBuilder;
  final bool Function(AsyncState<T> previous, AsyncState<T> current)? buildWhen;
  final Key? skeletonizerKey;

  const AsyncSliverBlocBuilder({
    super.key,
    required this.builder,
    this.skeletonBuilder,
    this.errorBuilder,
    this.buildWhen,
    this.skeletonizerKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, AsyncState<T>>(
      buildWhen: buildWhen,
      builder: (context, state) {
        switch (state.status) {
          case BaseStatus.initial:
          case BaseStatus.loading:
          case BaseStatus.loadingMore:
            final Widget skeletonChild;
            if (skeletonBuilder != null) {
              skeletonChild = skeletonBuilder!(context);
            } else {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Skeletonizer.sliver(
              key: skeletonizerKey,
              enabled: true,
              child: skeletonChild,
            );
          case BaseStatus.error:
            if (errorBuilder != null) {
              return SliverFillRemaining(
                child: errorBuilder!(context, state.errorMessage ?? ''),
              );
            }
            return SliverFillRemaining(
              child: ErrorView(error: state.errorMessage ?? ''),
            );
          case BaseStatus.success:
            return builder(context, state.data);
        }
      },
    );
  }
}
