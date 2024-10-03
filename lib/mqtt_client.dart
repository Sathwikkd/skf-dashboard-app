import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:convert';

class MQTTClientManager {
  MqttServerClient? client;
  final String broker = 'biometricunit.vsensetech.in';
  final int port = 1883;

  Function(String topic, String payload)? onMessageReceived; 

  Future<void> initializeMQTT() async {
    client = MqttServerClient(broker, '');
    client!.port = port;
    client!.keepAlivePeriod = 60;
    client!.onDisconnected = onDisconnected;
    client!.onConnected = onConnected;
    client!.logging(on: true);
    client!.onSubscribed = onSubscribed;
    client!.onUnsubscribed = onUnsubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .withWillTopic('willtopic') 
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    
    client!.connectionMessage = connMessage;

    try {
      await client!.connect();
    } catch (e) {
      print('Error: $e');
      client!.disconnect();
    }

    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');
    } else {
      print('MQTT connection failed');
      client!.disconnect();
    }
  }

  void onConnected() {
    print('Connected');
    _subscribeToTopics(); 
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed');
  }

  void _subscribeToTopics() {
    client!.subscribe('vs24skf01/stream_temp', MqttQos.atMostOnce);
    client!.subscribe('vs24skf01/stream_pid', MqttQos.atMostOnce);
    client!.subscribe('vs24skf01/update_temp', MqttQos.atMostOnce);
    client!.subscribe('vs24skf01/update_pid', MqttQos.atMostOnce);

    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('Received message: $payload from topic: ${c[0].topic}>');

      if (onMessageReceived != null) {
        onMessageReceived!(c[0].topic, payload); 
      }
    });
  }

  void disconnect() {
    client!.disconnect();
  }
}
