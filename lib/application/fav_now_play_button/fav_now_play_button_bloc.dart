import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fav_now_play_button_event.dart';
part 'fav_now_play_button_state.dart';

class FavNowPlayButtonBloc
    extends Bloc<FavNowPlayButtonEvent, FavNowPlayButtonState> {
  FavNowPlayButtonBloc() : super(FavNowPlayButtonInitial()) {
    on<NowFavButtonAdd>((event, emit) {
      return emit(FavNowPlayButtonState(isPressed: true));
    });
    on<NowFavRemove>((event, emit) {
      return emit(FavNowPlayButtonState(isPressed: false));
    });
  }
}
