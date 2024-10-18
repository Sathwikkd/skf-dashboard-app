import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:skf_project/core/mqtt/mqtt_client.dart';

part 'temperature_event.dart';
part 'temperature_state.dart';

class StreamData {
  final dynamic data;
  final String topic;
  StreamData({required this.data, required this.topic});
}

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {
  final MqttClientManager mqttClientManager;
  late StreamController<StreamData> _mqttStreamController;
  TemperatureBloc({required this.mqttClientManager})
      : super(TemperatureInitial()) {
    _mqttStreamController = StreamController<StreamData>();

    on<FetchDataFromMqttEvent>((event, emit) async {
      try {
        mqttClientManager.initilizeMqtt();
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
      var data = jsonDecode(payload);
      _mqttStreamController.add(StreamData(data: data, topic: topic));
    };
    on<StopStreamEvent>((event, emit) async {
      await mqttClientManager.disconnect(); // Call a method to close the MQTT connection.
      await _mqttStreamController.close();
    });
  }
}
