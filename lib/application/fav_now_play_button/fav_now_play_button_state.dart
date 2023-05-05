part of 'fav_now_play_button_bloc.dart';

 class FavNowPlayButtonState {
  bool isPressed ;
  FavNowPlayButtonState({required this.isPressed});
 }

class FavNowPlayButtonInitial extends FavNowPlayButtonState {
  FavNowPlayButtonInitial():super(isPressed: false);
}
