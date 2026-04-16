import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/bloc_widget.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupon_details_cubit.dart';

import '../../../location/imports/location_imports.dart';
import '../../../qr_scanner/presentation/view/scan_coupon_view.dart';
import '../widgets/calculate_discount_bottom_sheet.dart';
import 'view_imports.dart';

class CouponDetailsScreen extends BlocStatelessWidget<CouponDetailsCubit> {
  final int id;
  final CouponEntity? coupon;

  const CouponDetailsScreen({super.key, required this.id, this.coupon});

  @override
  CouponDetailsCubit get create {
    final cubit = injector<CouponDetailsCubit>();
    if (coupon != null) {
      cubit.setInitialData(coupon!);
    }
    return cubit..getCouponDetails(id.toString());
  }

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingButtonWithIcon(
                      title: state.isSuccess && (state.data.isUsed ?? false)
                          ? LocaleKeys.couponUsedBefore
                          : LocaleKeys.scanCouponCode,
                      isDissabled:
                          state.isSuccess && (state.data.isUsed ?? false),
                      onTap: () async {
                        if (!UserCubit.instance.checkMembership()) return;
                        if (state.isSuccess) {
                          final currentCoupon = state.data;

                          final invoiceAmount = await showDefaultBottomSheet(
                            context: context,
                            child: CalculateDiscountBottomSheet(
                              coupon: currentCoupon,
                            ),
                          );

                          if (invoiceAmount != null &&
                              invoiceAmount is double) {
                            Go.to(
                              ScanCouponView(
                                isActive: true,
                                couponId: id,
                                initialQrPayload: currentCoupon.qrPayload,
                                price: invoiceAmount,
                              ),
                            );
                          }
                        } else if (state.isError) {
                          MessageUtils.showSnackBar(
                            message:
                                state.errorMessage ?? LocaleKeys.operationFaild,
                            baseStatus: BaseStatus.error,
                          );
                        }
                      },
                      icon: AppAssets.svg.baseSvg.coupon.path,
                    ),
                  ],
                ),
              );
            },
          ),
      slivers: const [CouponDetailsBody()],
    );
  }
}
