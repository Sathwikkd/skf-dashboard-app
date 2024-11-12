import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/core/constants/routes.dart';
import 'package:skf_project/core/mqtt/mqtt_client.dart';
import 'package:http/http.dart' as http;

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final MqttClientManager mqttClientManager;
  late StreamController<StreamStatusData> _mqttStreamController;

  StatusBloc({required this.mqttClientManager}) : super(StatusInitial()) {
    // Use a broadcast stream to allow multiple listeners
    _mqttStreamController = StreamController<StreamStatusData>.broadcast();

    // Handle fetching status data event
    on<FetchStatusDataEvent>((event, emit) async {
      try {
        emit(FetchStatusDataLoadingState());

        // Fetch data from the server
        final jsonResponse = await http.get(
          Uri.parse("${HttpRoutes.fetchStatus}/${event.plcId}/${event.drierId}"),
        );

        // Check if the response status code is not 200
        if (jsonResponse.statusCode != 200) {
          emit(FetchStatusDataFailedState());
          return;
        }

        // Parse the JSON response as a List
        List<dynamic> response = jsonDecode(jsonResponse.body)['statuses'];

        if (response.isEmpty) {
          emit(FetchStatusDataFailedState());
          return;
        }

        // Emit data for each entry in the response list
        for (var item in response) {
          if (item is Map<String, dynamic>) {
            print(item);
            emit(FetchStatusDataSuccessState(
              data: {item['reg_type']: item['reg_value']},
              topic: "",
            ));
          }
        }

        // Initialize the MQTT client and listen for updates
        mqttClientManager.initilizeMqtt(event.drierId);

        // Listen to the MQTT stream
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
        print("Error: $e");
        emit(FetchStatusDataFailedState());
      }
    });

    // Handle MQTT messages
    mqttClientManager.onMessageReceived = (String topic, String payload) {
      var data = jsonDecode(payload);
      _mqttStreamController.add(StreamStatusData(data: data, topic: topic));
    };

    // Handle stopping the MQTT stream
    on<StopStatusStreamEvent>((event, emit) async {
      await mqttClientManager.disconnect();
      if (!_mqttStreamController.isClosed) {
        await _mqttStreamController.close();
      }
    });
  }
}

// Data structure to hold MQTT stream data
class StreamStatusData {
  final dynamic data;
  final String topic;
  StreamStatusData({required this.data, required this.topic});
}
