part of 'temperature_bloc.dart';

@immutable
sealed class TemperatureState {}

final class TemperatureInitial extends TemperatureState {}

final class FetchDataFromMqttSuccessState extends TemperatureState{
  final dynamic data;
  final String topic;
  FetchDataFromMqttSuccessState({required this.data , required this.topic});
}

final class FetchDataFromMqttFailureState extends TemperatureState{
  final String message;
  FetchDataFromMqttFailureState({required this.message});
}
