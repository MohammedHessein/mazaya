import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/bloc_widget.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';

import '../../../location/imports/location_imports.dart';
import 'view_imports.dart';

class CouponDetailsScreen extends BlocStatelessWidget<CouponDetailsCubit> {
  final int id;

  const CouponDetailsScreen({super.key, required this.id});

  @override
  CouponDetailsCubit get create =>
      injector<CouponDetailsCubit>()..getCouponDetails(id.toString());

  @override
  Widget buildContent(BuildContext context, CouponDetailsCubit ref) {
    return DefaultScaffold(
      header: HeaderConfig(
        title: LocaleKeys.couponDetails,
        showBackButton: false,
      ),
      bottomNavigationBar:
          BlocBuilder<CouponDetailsCubit, AsyncState<CouponEntity>>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(AppPadding.pW20),
                child: LoadingButtonWithIcon(
                  title: LocaleKeys.scanCouponCode,
                  onTap: () async {
                    Go.offAll(const MainScreen(initialTabIndex: 2));
                  },
                  icon: AppAssets.svg.baseSvg.coupon.path,
                ),
              );
            },
          ),
      slivers: const [CouponDetailsBody()],
    );
  }
}
