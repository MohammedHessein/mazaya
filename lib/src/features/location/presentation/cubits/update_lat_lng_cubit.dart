import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

@injectable
class UpdateLatLngCubit extends AsyncCubit<void> {
  UpdateLatLngCubit() : super(null);

  Future<void> checkAndUpdateLocation() async {
    try {
      final position = await LocationHelper.getCurrentLocation();
      
      final double? lastLat = CacheStorage.read(ConstantManager.lastLat);
      final double? lastLng = CacheStorage.read(ConstantManager.lastLng);

      if (lastLat != null && lastLng != null) {
        final double distance = Geolocator.distanceBetween(
          lastLat,
          lastLng,
          position.latitude,
          position.longitude,
        );

        // If distance is less than 5000 meters (5km), do nothing
        if (distance < 5000) {
          return;
        }
      }

      // If we are here, it means either:
      // 1. lastLat/lastLng are null (first time)
      // 2. distance is > 5km
      await _updateLocation(position.latitude, position.longitude);
      
    } catch (e) {
      // Fail silently for background location updates
    }
  }

  Future<void> _updateLocation(double lat, double lng) async {
    await executeAsync(
      showErrorToast: false, // Background operation should be silent
      operation: () async => await baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.updateLatLng,
          isFromData: true,
          body: {
            '_method': 'put',
            'lat': lat.toString(),
            'lng': lng.toString(),
          },
          httpRequestType: HttpRequestType.post,
          mapper: (json) => null,
        ),
      ),
      successEmitter: (_) async {
        await CacheStorage.write(ConstantManager.lastLat, lat);
        await CacheStorage.write(ConstantManager.lastLng, lng);
      },
    );
  }
}
