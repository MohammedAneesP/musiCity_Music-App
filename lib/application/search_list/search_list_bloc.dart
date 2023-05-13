import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';

part 'search_list_event.dart';
part 'search_list_state.dart';

class SearchListBloc extends Bloc<SearchListEvent, SearchListState> {
  SearchListBloc() : super(SearchListInitial()) {
    on<InitialListing>((event, emit) {
      List<AllSong> searchFull = allSongList.values.toList();
      log("in initial");
      return emit(SearchListState(
          searchStateSongs: searchFull, filteringSong: [], isNull: false));
    });
    on<SearchListingShowing>((event, emit) {
      List<AllSong> searchFull = allSongList.values.toList();
      List<AllSong> filteredSongs = searchFull.where((element) {
        final searchValue = element.songName.toLowerCase();
        final searchQuery = event.query.toLowerCase();
        return searchValue.contains(searchQuery);
      }).toList();
      if (filteredSongs.isEmpty) {
        log("not Found");
        return emit(SearchListState(
            searchStateSongs: [], filteringSong: [], isNull: true));
      } else {
        return emit(SearchListState(
            searchStateSongs: searchFull,
            filteringSong: filteredSongs,
            isNull: false));
      }
    });
  }
}
