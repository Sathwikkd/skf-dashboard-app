import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';
import 'package:skf_project/features/active_device/temp_and_pid.dart';
import 'package:skf_project/features/home/pages/home_page.dart';
import 'package:skf_project/mqtt_client.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case "/temp":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TemperatureBloc(mqttClientManager: MQTTClientManager()),
            child: const TemperaturePidPage(),
          ),
        );
    }
  }
}
