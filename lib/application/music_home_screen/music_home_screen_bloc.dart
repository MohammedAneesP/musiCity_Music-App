import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/main.dart';
import 'package:musi_city/models/home_models.dart';

part 'music_home_screen_event.dart';
part 'music_home_screen_state.dart';

class MusicHomeScreenBloc
    extends Bloc<MusicHomeScreenEvent, MusicHomeScreenState> {
  MusicHomeScreenBloc() : super(MusicHomeScreenInitial()) {
    on<HomeScreenSong>((event, emit) {
      List<AllSong> allBlocSongs = allSongList.values.toList();

      return emit(MusicHomeScreenState(homeSongs: allBlocSongs));
    });
  }
}
