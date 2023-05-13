part of 'search_list_bloc.dart';

 class SearchListState {
  List<AllSong> searchStateSongs;
  List<AllSong>filteringSong;
  bool isNull;

  SearchListState({required this.searchStateSongs,required this.filteringSong,required this.isNull});
 }

class SearchListInitial extends SearchListState {
  SearchListInitial():super(searchStateSongs: [],filteringSong: [],isNull: true);
}
