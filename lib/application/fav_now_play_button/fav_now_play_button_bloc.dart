import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/models/favorite_model.dart';

part 'fav_now_play_button_event.dart';
part 'fav_now_play_button_state.dart';

class FavNowPlayButtonBloc
    extends Bloc<FavNowPlayButtonEvent, FavNowPlayButtonState> {
  FavNowPlayButtonBloc() : super(FavNowPlayButtonInitial()) {
    on<NowFavInitial>((event, emit) {
      List<FavoriteModel>favListBloc = favoriteSong.values.toList();
      return emit(FavNowPlayButtonState(favStateList: favListBloc));
    });
     
  }
}
