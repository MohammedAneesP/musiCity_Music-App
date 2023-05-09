part of 'music_home_screen_bloc.dart';

 class MusicHomeScreenState {
  List<AllSong>homeSongs;
  

  MusicHomeScreenState({required this.homeSongs});
 }

class MusicHomeScreenInitial extends MusicHomeScreenState {
  MusicHomeScreenInitial():super(homeSongs: []);
}
