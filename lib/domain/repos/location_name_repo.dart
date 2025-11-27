import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationNameRepo {
  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  });
}
