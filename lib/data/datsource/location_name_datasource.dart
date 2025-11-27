import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:yandex/core/constants/app_constants.dart';

abstract class LocationNameDatasource {
  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  });
}

class LocationNameDatasourceImpl implements LocationNameDatasource {
  final Dio dio = Dio();

  @override
  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=${Appconstants.apikeyGoogleMap}";

      final response = await dio.get(url);

      log(response.data.toString());

      if (response.statusCode != 200) {
        throw Exception("Server xatosi: ${response.statusCode}");
      }

      log("Directions data: ${response.data}");

      final routes = response.data["routes"];
      if (routes == null || routes.isEmpty) {
        throw Exception("Route topilmadi !!!");
      }

      final encodedPolyline = routes[0]["overview_polyline"]["points"];

      List<PointLatLng> decoded = PolylinePoints.decodePolyline(
        encodedPolyline,
      );

      return decoded.map((e) => LatLng(e.latitude, e.longitude)).toList();
    } catch (e) {
      log("Xatolik: $e");
      throw Exception("Route olshda xatolik: $e");
    }
  }
}
