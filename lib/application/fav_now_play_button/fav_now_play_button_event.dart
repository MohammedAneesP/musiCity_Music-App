part of 'fav_now_play_button_bloc.dart';

@immutable
abstract class FavNowPlayButtonEvent {}

class NowFavInitial extends FavNowPlayButtonEvent{}
 
class NowFavAdded extends FavNowPlayButtonEvent{}

