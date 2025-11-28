import 'package:yandex/data/models/search_place_model.dart';

abstract class SearchPlaceRepo {
  Future<SearchPlaceModel> getSuggetions({required String search});
}
