part of 'favorite_list_bloc.dart';

 class FavoriteListState {
  List<FavoriteModel>favStateList;
  List<Audio>favStateAudio;
  

  FavoriteListState({required this.favStateList,required this.favStateAudio});
}

class FavoriteListInitial extends FavoriteListState {
  FavoriteListInitial():super(favStateList: [],favStateAudio: []);
}
