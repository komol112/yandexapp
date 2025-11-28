import 'package:yandex/data/datsource/search_place_datasource.dart';
import 'package:yandex/data/models/search_place_model.dart';
import 'package:yandex/domain/repos/search_place_repo.dart';

class SearchPlaceRepoImpl implements SearchPlaceRepo {
  final SearchPlaceDatasource searchPlaceDatasource;

  SearchPlaceRepoImpl({required this.searchPlaceDatasource});

  @override
  Future<SearchPlaceModel> getSuggetions({required String search}) async {
    return await searchPlaceDatasource.getSuggetions(seaech: search);
  }
}
