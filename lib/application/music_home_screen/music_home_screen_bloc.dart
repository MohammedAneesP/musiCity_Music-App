import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';

part 'music_home_screen_event.dart';
part 'music_home_screen_state.dart';

class MusicHomeScreenBloc
    extends Bloc<MusicHomeScreenEvent, MusicHomeScreenState> {
  List<AllSong> allBlocSongs = allSongList.values.toList();
  List<Audio> allSongConvert = [];
  MusicHomeScreenBloc() : super(MusicHomeScreenInitial()) {
    on<HomeScreenSong>((event, emit) {
      for (var element in allBlocSongs) {
        allSongConvert.add(
          Audio.file(
            element.songurl,
            metas: Metas(
              id: element.id.toString(),
              title: element.artists,
              artist: element.artists,
            ),
          ),
        );
      }
      return emit(
        MusicHomeScreenState(
          homeSongs: allBlocSongs,
          homeSongConvert: allSongConvert,
        ),
      );
    });
  }
}
