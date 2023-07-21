import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  static const CameraPosition defaultCameraPosition = _israelCameraPosition;

  static String _darkMapStyle = "";
  static final Completer<GoogleMapController> _controller = Completer();

  static Future<void> _loadDarkStyle() async {
    try {
      _darkMapStyle = await rootBundle.loadString(_darkMapStylePath);
    } finally {}
  }

  static void init() async {
    await _loadDarkStyle();
  }

  static onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle(_darkMapStyle);
  }

  static Future<void> goto(CameraPosition newCameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  static Future<void> disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }
}

const _darkMapStylePath = 'assets/json/map_styles/night.json';

const _israelCameraPosition = CameraPosition(
  target: LatLng(31.53156914572053, 34.86105938304329),
  zoom: 8.0,
);
