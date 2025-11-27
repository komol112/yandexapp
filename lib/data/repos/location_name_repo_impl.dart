import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yandex/data/datsource/location_name_datasource.dart';
import 'package:yandex/domain/repos/location_name_repo.dart';

class LocationNameRepoImpl implements LocationNameRepo {
  final LocationNameDatasource locationNameDatasource;

  LocationNameRepoImpl({required this.locationNameDatasource});

  @override
  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      log("repo impl : $start, long: $end");
      return await locationNameDatasource.getRoutePoints(
        start: start,
        end: end,
      );
    } catch (e) {
      log(e.toString());
      log("repo iimplda xatolik kuzatildai !");
      throw Exception(e);
    }
  }
}
