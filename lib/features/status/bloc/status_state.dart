part of 'status_bloc.dart';

@immutable
sealed class StatusState {}

final class StatusInitial extends StatusState {}


final class FetchStatusDataSuccessState extends StatusState{
  final dynamic data;
  final String topic;
  FetchStatusDataSuccessState({required this.data , required this.topic});
}


final class FetchStatusDataFailedState extends StatusState{}


final class FetchStatusDataLoadingState extends StatusState{}