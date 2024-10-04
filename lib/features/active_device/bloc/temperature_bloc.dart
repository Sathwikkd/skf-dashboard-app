import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async'; // For StreamController
import 'package:skf_project/mqtt_client.dart';

part 'temperature_event.dart';
part 'temperature_state.dart';


class StreamData {
  final String data;
  final String topic;
  StreamData({required this.data, required this.topic});
} 

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {
  final MQTTClientManager mqttClientManager;
  late StreamController<StreamData> _mqttStreamController;
  TemperatureBloc({required this.mqttClientManager})
      : super(TemperatureInitial()) {
    _mqttStreamController = StreamController<StreamData>();

    on<FetchDataFromMqttEvent>((event, emit) async {
      try {
        mqttClientManager.initializeMQTT();
        await emit.forEach<StreamData>(
          _mqttStreamController.stream,
          onData: (data) {
            return FetchDataFromMqttSuccessState(
              data: data.data,
              topic: data.topic,
            );
          },
          onError: (error, stackTrace) => FetchDataFromMqttFailureState(),
        );
      } catch (e) {
        emit(FetchDataFromMqttFailureState());
      }
    });
    mqttClientManager.onMessageReceived = (String topic, String payload) {
      _mqttStreamController.add(StreamData(data: payload, topic: topic));
    };
  }

  @override
  Future<void> close() {
    _mqttStreamController.close();
    return super.close();
  }
}
