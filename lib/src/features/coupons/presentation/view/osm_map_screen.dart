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

  const OsmMapScreen({
    super.key,
    required this.lat,
    required this.lng,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();

    // Normalizes longitude to [-180, 180] and clamps latitude to [-90, 90]
    double normalizeLat(double l) => l.clamp(-90.0, 90.0);
    double normalizeLng(double g) => ((g + 180) % 360) - 180;

    final double nLat = normalizeLat(lat);
    final double nLng = normalizeLng(lng);

    final LatLng vendorPoint = LatLng(nLat, nLng);

    return DefaultScaffold(
      header: HeaderConfig(title: title, showBackButton: false),
      slivers: [
        SliverFillRemaining(
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(initialCenter: vendorPoint, initialZoom: 13.0),
            children: [
              TileLayer(
                urlTemplate: ConstantManager.mapUrlTemplate,
                userAgentPackageName: ConstantManager.mapUserAgent,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: vendorPoint,
                    width: 60.w,
                    height: 60.h,
                    child: IconWidget(
                      icon: AppAssets.svg.baseSvg.location.path,
                      color: AppColors.primary,
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
