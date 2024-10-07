import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';
import 'package:skf_project/features/active_device/pages/temp_and_pid.dart';
import 'package:skf_project/features/home/pages/home_page.dart';
import 'package:skf_project/features/recipe_temp/pages/recipe_page.dart';
import 'package:skf_project/features/status/status_page.dart';
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
            create: (context) =>
                TemperatureBloc(mqttClientManager: MqttClientManager()),
            child: const TemperaturePidPage(),
          ),
        );
      case "/recipe":
        return MaterialPageRoute(
          builder: (context) => const RecipePage(),
        );
      case "/status":
        return MaterialPageRoute(
          builder: (context) => const StatusPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
