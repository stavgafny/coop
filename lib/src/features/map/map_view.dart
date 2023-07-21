import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './services/map_service.dart';
import './services/location_service.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Position? _position;
  bool _gotLocation = false;

  @override
  void initState() {
    super.initState();
    MapService.init();
    LocationService.getLastLocation().then((position) {
      _position = position;
      _gotLocation = true;
      setState(() {});
      Geolocator.getServiceStatusStream().listen((event) async {
        if (event == ServiceStatus.enabled) {
          final position = await Geolocator.getCurrentPosition();
          MapService.goto(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 12.0),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_gotLocation) return const SizedBox.shrink();

    CameraPosition cameraPosition = MapService.defaultCameraPosition;
    if (_position != null) {
      final latitude = _position!.latitude;
      final longitude = _position!.longitude;
      cameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 12.0,
      );
    }

    return GoogleMap(
      compassEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: MapService.onMapCreated,
    );
  }

  @override
  void dispose() {
    MapService.disposeController();
    super.dispose();
  }
}
