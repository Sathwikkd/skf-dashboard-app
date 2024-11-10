import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/core/mqtt/mqtt_client.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final MqttClientManager mqttClientManager;
  late StreamController<StreamStatusData> _mqttStreamController;
  StatusBloc({required this.mqttClientManager}) : super(StatusInitial()) {
    _mqttStreamController = StreamController<StreamStatusData>();
    on<FetchStatusDataEvent>((event , emit) async {
        try {
        mqttClientManager.initilizeMqtt(event.drierId);
        await emit.forEach<StreamStatusData>(
          _mqttStreamController.stream,
          onData: (data) {
            return FetchStatusDataSuccessState(
              data: data.data,
              topic: data.topic,
            );
          },
          onError: (error, stackTrace) => FetchStatusDataFailedState(),
        );
      } catch (e) {
        emit(FetchStatusDataFailedState());
      }
    });
     mqttClientManager.onMessageReceived = (String topic, String payload) {
      var data = jsonDecode(payload);
      _mqttStreamController.add(StreamStatusData(data: data, topic: topic));
    };
    on<StopStatusStreamEvent>((event, emit) async {
      await mqttClientManager.disconnect(); // Call a method to close the MQTT connection.
      await _mqttStreamController.close();
    });
  }
}

class StreamStatusData{
  final dynamic data;
  final String topic;
  StreamStatusData({required this.data, required this.topic});
}
