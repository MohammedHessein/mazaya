import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/features/qr_scanner/entity/scan_result.dart';

@injectable
class ScanCubit extends AsyncCubit<ScanResult> {
  ScanCubit() : super(const ScanResult.empty());

  Future<void> scanQR(String qrPayload, [int? couponId]) async {
    // final String deviceId = NotificationService.deviceToken.isEmpty
    //     ? 'no'
    //     : NotificationService.deviceToken;
    final String deviceId = 'test800';
    final Map<String, dynamic> requestBody = {'device_id': deviceId};
    String apiUrl = '${ApiConstants.scanQR}/$qrPayload';

    if (couponId != null) {
      requestBody['coupon_id'] = couponId;
    }

    final queryParams = <String, dynamic>{};

    await executeAsync(
      operation: () => baseCrudUseCase.call<ScanResult>(
        CrudBaseParams(
          api: apiUrl,
          httpRequestType: HttpRequestType.post,
          body: requestBody,
          queryParameters: queryParams,
          mapper: (json) => ScanResult.fromJson(json['data']),
        ),
      ),
    );
  }
}
