import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/core/mqtt/mqtt_client.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final MqttClientManager mqttClientManager;
  late StreamController<StreamRecipeData> _mqttStreamController;
  RecipeBloc({required this.mqttClientManager}) : super(RecipeInitial()) {
     _mqttStreamController = StreamController<StreamRecipeData>();
    on<FetchRecipeEvent>((event, emit) async {
      try {
        mqttClientManager.initilizeMqtt(event.drierId);
        await emit.forEach<StreamRecipeData>(
          _mqttStreamController.stream,
          onData: (data) {
            return FetchRecipeSuccessState(
              data: data.data,
              topic: data.topic,
            );
          },
          onError: (error, stackTrace) => FetchRecipeFailedState(),
        );
      } catch (e) {
        emit(FetchRecipeFailedState());
      }
    });
     mqttClientManager.onMessageReceived = (String topic, String payload) {
      var data = jsonDecode(payload);
      _mqttStreamController.add(StreamRecipeData(data: data, topic: topic));
    };
    on<StopRecipeFetchEvent>((event, emit) async {
      await mqttClientManager.disconnect();
      await _mqttStreamController.close();
    });
  }
}

class StreamRecipeData{
  final dynamic data;
  final String topic;
  StreamRecipeData({required this.data , required this.topic});
}
