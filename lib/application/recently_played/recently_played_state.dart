part of 'recently_played_bloc.dart';

 class RecentlyPlayedState {
 List<RecentlyModel>recentMusic;

 RecentlyPlayedState({required this.recentMusic});
}

class RecentlyPlayedInitial extends RecentlyPlayedState {

  RecentlyPlayedInitial():super(recentMusic: []);
}
