import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:skf_project/core/mqtt/mqtt_client.dart';

part 'temperature_event.dart';
part 'temperature_state.dart';

class RealtimeStreamData {
  final dynamic data;
  final String topic;
  RealtimeStreamData({required this.data, required this.topic});
}

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {

  // Declaring required classes
  final MqttClientManager mqttClientManager;
  late StreamController<RealtimeStreamData> _mqttStreamController;

  // Invoking constructor of bloc
  TemperatureBloc({required this.mqttClientManager})
      : super(TemperatureInitial()) {
    _mqttStreamController = StreamController<RealtimeStreamData>();
    // Bloc Part
    on<FetchDataFromMqttEvent>(_fetchDataFromMqtt);
    on<StopStreamEvent>(_stopStreaming);
    // Streaming Part
    mqttClientManager.onMessageReceived = (String topic, String payload) {
      var data = jsonDecode(payload);
      _mqttStreamController.add(RealtimeStreamData(data: data, topic: topic));
    };
  }

  // Bloc logic part to connect to Mqtt and Start Streaming
  Future<void> _fetchDataFromMqtt(FetchDataFromMqttEvent event , Emitter<TemperatureState> emit) async {
      try {
        // Initilizing mqtt client
        mqttClientManager.initilizeMqtt(event.drierId);
        await emit.forEach<RealtimeStreamData>(
          _mqttStreamController.stream,
          onData: (data) {
            return FetchDataFromMqttSuccessState(
              data: data.data,
              topic: data.topic,
            );
          },
          onError: (error, stackTrace) => FetchDataFromMqttFailureState(message: "Unable To Stream Data..."),
        );
      } catch (e) {
        emit(FetchDataFromMqttFailureState(message: "Unable To Stream Data..."));
      }
  }

  // Bloc logic part to Stop Streaming
  Future<void> _stopStreaming(StopStreamEvent event , Emitter<TemperatureState> emit) async {
     await mqttClientManager.disconnect();
      await _mqttStreamController.close();
  }
}
