part of 'temperature_bloc.dart';

@immutable
sealed class TemperatureEvent {}

class FetchDataFromMqttEvent extends TemperatureEvent{}
