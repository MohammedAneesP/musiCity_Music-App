import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/models/favorite_model.dart';

part 'favorite_list_event.dart';
part 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  FavoriteListBloc() : super(FavoriteListInitial()) {
    on<FavListingScreen>(
      (event, emit) {
        List<FavoriteModel> favAllSongs = favoriteSong.values.toList();
        List<Audio> favAudioBloc = [];
        for (var element in favAllSongs) {
          favAudioBloc.add(
            Audio.file(
              element.favSongUrl,
              metas: Metas(
                id: element.favSongId.toString(),
                title: element.favSongName,
                artist: element.favSongArtist,
              ),
            ),
          );
        }
        return emit(FavoriteListState(
            favStateList: favAllSongs, favStateAudio: favAudioBloc));
      },
    );
  }
}
