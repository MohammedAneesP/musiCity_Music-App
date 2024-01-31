
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/models/recently_model.dart';

part 'recently_played_event.dart';
part 'recently_played_state.dart';

class RecentlyPlayedBloc extends Bloc<RecentlyPlayedEvent, RecentlyPlayedState> {
  RecentlyPlayedBloc() : super(RecentlyPlayedInitial()) {
    on<RecentShowListEvent>((event, emit) {
      List<RecentlyModel> recBlocList = recentlyPlayedBox.values.toList();
      return emit(RecentlyPlayedState(recentMusic: recBlocList));
    });
  }
}
