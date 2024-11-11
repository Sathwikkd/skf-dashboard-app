import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class MqttClientManager {
   MqttServerClient? client;
  Function(String topic, String payload)? onMessageReceived;

  Future<void> initilizeMqtt(String subscribeTopic) async {
    // Initilizing all the required values of the client
    client =
        MqttServerClient.withPort("skfplc.http.vsensetech.in", "skf_plc_user_app", 1883);
    client!.keepAlivePeriod = 60;
    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;
    client!.onSubscribed = onSubscribed;
    client!.onUnsubscribed = onUnsubscribed;
    client!.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client!.connectionMessage = connMessage;

    // Trying to connect to mqtt
    try {
      await client!.connect();
    } catch (e) {
      client!.disconnect();
    }
    // Checking wheather the connection is alive or not
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      _subscribeToTopic(subscribeTopic);
      print("Connected to Mqtt");
    } else {
      print("Unable to Connect");
      client!.disconnect();
    }
  }

  // All Functions Related To Connection
  void onConnected() {
    print("Connected");
  }

  void onDisconnected() {
    print("Disconnected");
  }

  void onSubscribed(String topic) {
    print("Subscribed to $topic");
  }

  void onUnsubscribed(String? topic) {
    print("Unsubscribed to $topic");
  }

  void pong() {
    print("pong");
  }

  void _subscribeToTopic(String subTop) {
    client!.subscribe(subTop, MqttQos.atLeastOnce);
    
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

  Future<void> disconnect() async {
    client!.disconnect();
  }
}
