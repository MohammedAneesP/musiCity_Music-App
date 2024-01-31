import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:musi_city/functions/box_opening.dart';
import 'package:musi_city/models/mostly_model.dart';

part 'mostly_played_event.dart';
part 'mostly_played_state.dart';

class MostlyPlayedBloc extends Bloc<MostlyPlayedEvent, MostlyPlayedState> {
  MostlyPlayedBloc() : super(MostlyPlayedInitial()) {
    on<MostlyScreenShow>((event, emit) {
     List<MostlyModel>mostlyAnList = mostlyPlayedBox.values.toList();
     return emit(MostlyPlayedState(mostltStateList: mostlyAnList));
    });
  }
}
