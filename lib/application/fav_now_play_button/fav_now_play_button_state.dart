part of 'fav_now_play_button_bloc.dart';

 class FavNowPlayButtonState {
  
  List<FavoriteModel>favStateList;  
  FavNowPlayButtonState({required this.favStateList});
 }

class FavNowPlayButtonInitial extends FavNowPlayButtonState {
  FavNowPlayButtonInitial():super(favStateList: []);
}
