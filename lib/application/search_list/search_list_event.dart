part of 'search_list_bloc.dart';

@immutable
abstract class SearchListEvent {}

class InitialListing extends SearchListEvent {}

class SearchListingShowing extends SearchListEvent {
  String query;

  SearchListingShowing({required this.query});
}
