import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex/data/models/search_place_model.dart';
import 'package:yandex/domain/useceases/search_place_usecase.dart';
import 'package:yandex/presentation/blocs/search_bloc/search_place_event.dart';
import 'package:yandex/presentation/blocs/search_bloc/search_place_state.dart';

class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SearchPlaceUsecase searchPlaceUsecase;

  SearchPlaceBloc({required this.searchPlaceUsecase})
    : super(SearchPlaceInitial()) {
    on<FetchSearchPlaceEvent>(_onSearchPlaceTextChanged);
  }

  Future<void> _onSearchPlaceTextChanged(
    FetchSearchPlaceEvent event,
    Emitter<SearchPlaceState> emit,
  ) async {
    final query = event.search.trim();
    if (query.isEmpty) {
      emit(SearchPlaceInitial());
      return;
    }

    emit(SearchPlaceLoading());

    try {
      final SearchPlaceModel result = await searchPlaceUsecase.getSuggetions(
        search: query,
      );
      emit(SearchPlaceLoaded(searchPlaceModel: result));
    } catch (e) {
      emit(SearchPlaceError(message: e.toString()));
    }
  }
}
