import 'package:equatable/equatable.dart';
import 'package:yandex/data/models/search_place_model.dart';

abstract class SearchPlaceState extends Equatable {
  const SearchPlaceState();
  @override
  List<Object> get props => [];
}

class SearchPlaceInitial extends SearchPlaceState {}

class SearchPlaceLoading extends SearchPlaceState {}

class SearchPlaceLoaded extends SearchPlaceState {
  final SearchPlaceModel searchPlaceModel;
  const SearchPlaceLoaded({required this.searchPlaceModel});

  @override
  List<Object> get props => [searchPlaceModel];
}

class SearchPlaceError extends SearchPlaceState {
  final String message;
  const SearchPlaceError({required this.message});

  @override
  List<Object> get props => [message];
}
