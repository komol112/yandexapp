import 'dart:developer';

import 'package:yandex/data/models/search_place_model.dart';
import 'package:yandex/domain/repos/search_place_repo.dart';

class SearchPlaceUsecase {
  final SearchPlaceRepo searchPlaceRepo;

  SearchPlaceUsecase({required this.searchPlaceRepo});

  Future<SearchPlaceModel> getSuggetions({required String search}) async {
    try {
      log("search usecase ichida , input : $search");
      return await searchPlaceRepo.getSuggetions(search: search);
    } catch (e) {
      log("SearchPlaceUsecase icida xatolik: $e");
      throw Exception(e);
    }
  }
}
