import 'package:equatable/equatable.dart';

abstract class SearchPlaceEvent extends Equatable {
  const SearchPlaceEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchPlaceEvent extends SearchPlaceEvent {
  final String search;

  const FetchSearchPlaceEvent({required this.search});

  @override
  List<Object> get props => [search];
}
