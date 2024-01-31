import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/models/playlist_model.dart';
part 'playlist_listing_event.dart';
part 'playlist_listing_state.dart';

class PlaylistListingBloc
    extends Bloc<PlaylistListingEvent, PlaylistListingState> {
  PlaylistListingBloc() : super(PlaylistListingInitial()) {
    on<PlayListShow>((event, emit) {
      List<PlaylistModel> playListEmitList = myPlaylist.values.toList();
      return emit(PlaylistListingState(anNewPlayList: playListEmitList));
    });
  }
}
