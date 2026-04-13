import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'view_imports.dart';

class OsmMapScreen extends StatefulWidget {
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
  State<OsmMapScreen> createState() => _OsmMapScreenState();
}

class _OsmMapScreenState extends State<OsmMapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Normalizes longitude to [-180, 180] and clamps latitude to [-90, 90]
    double normalizeLat(double l) => l.clamp(-90.0, 90.0);
    double normalizeLng(double g) => ((g + 180) % 360) - 180;

    final double nLat = normalizeLat(widget.lat);
    final double nLng = normalizeLng(widget.lng);

    final LatLng vendorPoint = LatLng(nLat, nLng);

    return DefaultScaffold(
      header: HeaderConfig(title: widget.title, showBackButton: false),
      slivers: [
        SliverFillRemaining(
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: vendorPoint,
                  initialZoom: 13.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
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
              Positioned(
                bottom: 20.h,
                right: 20.w,
                child: Column(
                  children: [
                    _ZoomButton(
                      icon: Icons.add,
                      onPressed: () {
                        final currentZoom = _mapController.camera.zoom;
                        _mapController.move(
                          _mapController.camera.center,
                          currentZoom + 1,
                        );
                      },
                    ),
                    10.szH,
                    _ZoomButton(
                      icon: Icons.remove,
                      onPressed: () {
                        final currentZoom = _mapController.camera.zoom;
                        _mapController.move(
                          _mapController.camera.center,
                          currentZoom - 1,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ZoomButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.primary, size: 28.r),
        onPressed: onPressed,
      ),
    );
  }
}
