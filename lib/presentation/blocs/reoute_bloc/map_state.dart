import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {}

class MapInitialState extends MapState {}

class MapLoadingState extends MapState {}

class MapAddressLoadedState extends MapState {
  final String address;
  MapAddressLoadedState(this.address);
}

class MapRouteLoadedState extends MapState {
  final List<LatLng> points;
  MapRouteLoadedState(this.points);
}

class MapErrorState extends MapState {
  final String message;
  MapErrorState(this.message);
}
