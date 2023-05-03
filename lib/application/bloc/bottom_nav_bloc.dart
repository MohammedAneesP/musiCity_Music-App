import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial()) {
    on<MusiHomeScreenEvnt>(
      (event, emit) {
        return emit(BottomNavState(anCount: 0));
      },
    );
    on<FavoritesScreenEvnt>(
      (event, emit) {
        return emit(BottomNavState(anCount: 1));
      },
    );
    on<PlayalistScreenEvnt>((event, emit) {
      return emit(BottomNavState(anCount: 2));
    });
  }
}
