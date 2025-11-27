import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex/domain/useceases/location_name_usecease.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationNameUsecease locationNameUsecease;

  MapBloc({required this.locationNameUsecease}) : super(MapInitialState()) {
    on<FetchRouteEvent>((event, emit) async {
      emit(MapLoadingState());
      try {
        final points = await locationNameUsecease.getRoutePoints(
          start: event.start,
          end: event.end,
        );
        emit(MapRouteLoadedState(points));
      } catch (e) {
        emit(MapErrorState(e.toString()));
      }
    });
  }
}
