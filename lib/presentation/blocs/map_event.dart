import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class FetchRouteEvent extends MapEvent {
  final LatLng start;
  final LatLng end;
  FetchRouteEvent({required this.start, required this.end});
}
