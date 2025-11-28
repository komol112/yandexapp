import 'package:get_it/get_it.dart';
import 'package:yandex/data/datsource/location_name_datasource.dart';
import 'package:yandex/data/datsource/search_place_datasource.dart';
import 'package:yandex/data/repos/location_name_repo_impl.dart';
import 'package:yandex/data/repos/search_place_repo_impl.dart';
import 'package:yandex/domain/repos/location_name_repo.dart';
import 'package:yandex/domain/repos/search_place_repo.dart';
import 'package:yandex/domain/useceases/location_name_usecease.dart';
import 'package:yandex/domain/useceases/search_place_usecase.dart';
import 'package:yandex/presentation/blocs/reoute_bloc/map_bloc.dart';
import 'package:yandex/presentation/blocs/search_bloc/search_place_bloc.dart';

final sl = GetIt.instance;

void init() {
  //hullas bu yerda route yol uchun registratsya bolyabdi
  sl.registerLazySingleton<LocationNameDatasource>(
    () => LocationNameDatasourceImpl(),
  );
  sl.registerLazySingleton<LocationNameRepo>(
    () => LocationNameRepoImpl(
      locationNameDatasource: sl<LocationNameDatasource>(),
    ),
  );
  sl.registerLazySingleton<LocationNameUsecease>(
    () => LocationNameUsecease(locationNameRepo: sl<LocationNameRepo>()),
  );
  sl.registerFactory<MapBloc>(
    () => MapBloc(locationNameUsecease: sl<LocationNameUsecease>()),
  );

  //bu yerda searchni registratsiyasi bolyabdi

  sl.registerLazySingleton<SearchPlaceDatasource>(
    () => SearchPlaceDatasourceImpl(),
  );
  sl.registerLazySingleton<SearchPlaceRepo>(
    () =>
        SearchPlaceRepoImpl(searchPlaceDatasource: sl<SearchPlaceDatasource>()),
  );
  sl.registerLazySingleton<SearchPlaceUsecase>(
    () => SearchPlaceUsecase(searchPlaceRepo: sl<SearchPlaceRepo>()),
  );
  sl.registerFactory<SearchPlaceBloc>(
    () => SearchPlaceBloc(searchPlaceUsecase: sl<SearchPlaceUsecase>()),
  );
}
