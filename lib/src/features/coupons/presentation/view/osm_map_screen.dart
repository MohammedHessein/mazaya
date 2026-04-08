import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'view_imports.dart';

class OsmMapScreen extends StatelessWidget {
  final double lat;
  final double lng;
  final String title;
  final double? userLat;
  final double? userLng;

  const OsmMapScreen({
    super.key,
    required this.lat,
    required this.lng,
    required this.title,
    this.userLat,
    this.userLng,
  });

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();

    return DefaultScaffold(
      header: HeaderConfig(title: title, showBackButton: false),
      slivers: [
        SliverFillRemaining(
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: LatLng(lat, lng),
              initialZoom: 13.0,
              onMapReady: () {
                if (userLat != null && userLng != null) {
                  mapController.fitCamera(
                    CameraFit.bounds(
                      bounds: LatLngBounds(
                        LatLng(lat, lng),
                        LatLng(userLat!, userLng!),
                      ),
                      padding: const EdgeInsets.all(50),
                    ),
                  );
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: ConstantManager.mapUrlTemplate,
                userAgentPackageName: ConstantManager.mapUserAgent,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(lat, lng),
                    width: 60.w,
                    height: 60.h,
                    child: IconWidget(
                      icon: AppAssets.svg.baseSvg.location.path,
                      color: AppColors.primary,
                      height: 50.h,
                    ),
                  ),
                  if (userLat != null && userLng != null)
                    Marker(
                      point: LatLng(userLat!, userLng!),
                      width: 60.w,
                      height: 60.h,
                      child: IconWidget(
                        icon: AppAssets.svg.baseSvg.location.path,
                        color: Colors.blue,
                        height: 50.h,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
