part of 'temperature_bloc.dart';

@immutable
sealed class TemperatureEvent {}

class FetchDataFromMqttEvent extends TemperatureEvent{
  final String drierId;
  FetchDataFromMqttEvent({required this.drierId});
}


class StopStreamEvent extends TemperatureEvent{}
