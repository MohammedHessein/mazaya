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
    return DefaultScaffold(
      header: HeaderConfig(
        title: title,
        showBackButton: false,
      ),
      slivers: [
        SliverFillRemaining(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(lat, lng),
              initialZoom: 15.0,
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
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
