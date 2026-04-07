part of '../imports/view_imports.dart';

class UsedCouponsScreen extends StatefulWidget {
  const UsedCouponsScreen({super.key});

  @override
  State<UsedCouponsScreen> createState() => _UsedCouponsScreenState();
}

class _UsedCouponsScreenState extends State<UsedCouponsScreen> {
  late final UsedCouponsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = injector<UsedCouponsCubit>();
    _cubit.fetchUsedCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const UsedCouponsBody(),
    );
  }
}
