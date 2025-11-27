import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yandex/domain/repos/location_name_repo.dart';

class LocationNameUsecease {
  final LocationNameRepo locationNameRepo;

  LocationNameUsecease({required this.locationNameRepo});

  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      log("useceaase malumoti : starrt : $start, end : $end");
      return await locationNameRepo.getRoutePoints(start: start, end: end);
    } catch (e) {
      throw Exception(e);
    }
  }
}
