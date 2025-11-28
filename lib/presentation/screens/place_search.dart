// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex/data/datsource/search_place_datasource.dart';
import 'package:yandex/presentation/blocs/search_bloc/search_place_bloc.dart';
import 'package:yandex/presentation/blocs/search_bloc/search_place_event.dart';
import 'package:yandex/presentation/blocs/search_bloc/search_place_state.dart';

class PlaceSearchDelegate extends SearchDelegate<LatLng?> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  @override
  String get searchFieldLabel => 'Qidirish...';

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  void _search(BuildContext context) {
    final searchPlaceBloc = context.read<SearchPlaceBloc>();
    searchPlaceBloc.add(FetchSearchPlaceEvent(search: query));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Center(child: Text('Qidirish...'));

    _search(context);

    return BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
      builder: (context, state) {
        if (state is SearchPlaceLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SearchPlaceLoaded) {
          final suggestions = state.searchPlaceModel.predictions;
          if (suggestions == null || suggestions.isEmpty) {
            return Center(child: Text('Natija topilmadi'));
          }
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final place = suggestions[index];
              return ListTile(
                title: Text(place.description ?? ""),
                onTap: () async {
                  final latLng = await SearchPlaceDatasourceImpl.getPlaceLatLng(
                    place.placeId ?? "yoq place id ",
                  );

                  close(context, latLng);
                },
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
