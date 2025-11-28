import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yandex/core/constants/app_constants.dart';
import 'package:yandex/data/models/search_place_model.dart';

abstract class SearchPlaceDatasource {
  Future<SearchPlaceModel> getSuggetions({required String seaech});
}

class SearchPlaceDatasourceImpl implements SearchPlaceDatasource {
  static Dio dio = Dio();

  @override
  Future<SearchPlaceModel> getSuggetions({required String seaech}) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$seaech&key=${Appconstants.apikeyGoogleMap}&language=uz";

      final response = await dio.get(url);
      log("datasourece response : ${response.data}");

      if (response.statusCode == 200) {
        log("datasourece 200 and response: ${response.data}");
        return SearchPlaceModel.fromJson(response.data);
      } else {
        throw Exception(
          "serchda muammolik ${response.statusCode} , response: ${response.data}",
        );
      }
    } catch (e) {
      log("catchga tushdi Search ichida xatolik: $e");
      throw Exception(e);
    }
  }

  //placeni id si boyica latitiute longitute olamiz

  static Future<LatLng?> getPlaceLatLng(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${Appconstants.apikeyGoogleMap}";

    final response = await dio.get(url);
    final data = response.data;

    if (data['status'] == 'OK') {
      final location = data['result']['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    }
    return null;
  }
}
