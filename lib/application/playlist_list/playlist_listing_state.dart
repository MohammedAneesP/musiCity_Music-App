part of 'playlist_listing_bloc.dart';

 class PlaylistListingState {
  //String playListNames;
  List<PlaylistModel>anNewPlayList;

  PlaylistListingState({required this.anNewPlayList});
 }

class PlaylistListingInitial extends PlaylistListingState {

  PlaylistListingInitial():super(anNewPlayList: []);
}
