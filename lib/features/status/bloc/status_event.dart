part of 'status_bloc.dart';

@immutable
sealed class StatusEvent {}


class FetchStatusDataEvent extends StatusEvent{
  final String drierId;
  FetchStatusDataEvent({required this.drierId});
}


class StopStatusStreamEvent extends StatusEvent{}
