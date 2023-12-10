part of 'recently_played_bloc.dart';

@immutable
abstract class RecentlyPlayedEvent {}

class RecentShowListEvent extends RecentlyPlayedEvent {}

class RecentlyPlayClear extends RecentlyPlayedEvent{}
