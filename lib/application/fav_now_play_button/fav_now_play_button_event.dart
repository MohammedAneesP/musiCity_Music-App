part of 'fav_now_play_button_bloc.dart';

@immutable
abstract class FavNowPlayButtonEvent {}

class NowFavButtonAdd extends FavNowPlayButtonEvent{}

class NowFavRemove extends FavNowPlayButtonEvent{}


