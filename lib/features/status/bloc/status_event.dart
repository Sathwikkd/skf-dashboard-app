part of 'status_bloc.dart';

@immutable
sealed class StatusEvent {}


class FetchStatusDataEvent extends StatusEvent{}


class StopStatusStreamEvent extends StatusEvent{}
