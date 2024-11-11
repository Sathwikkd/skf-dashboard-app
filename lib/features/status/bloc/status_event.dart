part of 'status_bloc.dart';

@immutable
sealed class StatusEvent {}


class FetchStatusDataEvent extends StatusEvent{
  final String drierId;
  final String plcId;
  FetchStatusDataEvent({required this.drierId , required this.plcId});
}


class StopStatusStreamEvent extends StatusEvent{}
