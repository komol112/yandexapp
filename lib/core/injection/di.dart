
import 'package:get_it/get_it.dart';
import 'package:yandex/data/datsource/location_name_datasource.dart';
import 'package:yandex/data/repos/location_name_repo_impl.dart';
import 'package:yandex/domain/repos/location_name_repo.dart';
import 'package:yandex/domain/useceases/location_name_usecease.dart';
import 'package:yandex/presentation/blocs/map_bloc.dart';

final sl = GetIt.instance;

void init() {
  //hullas bu yerda locatsiyani nomi uchun registratsya bolyabdi
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
}
