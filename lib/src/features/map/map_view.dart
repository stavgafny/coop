import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.53156914572053, 34.86090457898239),
    zoom: 14.4746,
  );

  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String? _darkMapStyle;

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/json/map_styles/night.json');
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      compassEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: MapView._kGooglePlex,
      onMapCreated: (controller) {
        controller.setMapStyle(_darkMapStyle);
      },
      markers: <Marker>{
        const Marker(
          markerId: MarkerId("id"),
          position: LatLng(31.53156914572053, 34.86090457898239),
        ),
      },
    );
  }
}
