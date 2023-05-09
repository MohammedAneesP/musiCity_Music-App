part of 'mostly_played_bloc.dart';

 class MostlyPlayedState {
List<MostlyModel>mostltStateList;

MostlyPlayedState({required this.mostltStateList});
}

class MostlyPlayedInitial extends MostlyPlayedState {
  MostlyPlayedInitial():super(mostltStateList: []);
}
