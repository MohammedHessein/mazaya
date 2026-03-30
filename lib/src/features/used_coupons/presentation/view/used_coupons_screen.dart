part of '../imports/view_imports.dart';

class UsedCouponsScreen extends StatelessWidget {
  const UsedCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UsedCouponsCubit>()..fetchInitialData(),
      child: const UsedCouponsBody(),
    );
  }
}
