part of 'music_home_screen_bloc.dart';

 class MusicHomeScreenState {
  List<AllSong>homeSongs;
  List<Audio>homeSongConvert;

  MusicHomeScreenState({required this.homeSongs,required this.homeSongConvert});
 }

class MusicHomeScreenInitial extends MusicHomeScreenState {
  MusicHomeScreenInitial():super(homeSongs: [],homeSongConvert: []);
}
