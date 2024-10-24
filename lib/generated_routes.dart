import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';
import 'package:skf_project/features/active_device/pages/temp_and_pid.dart';
import 'package:skf_project/features/auth/presentation/pages/login_page.dart';
import 'package:skf_project/features/home/pages/home_page.dart';
import 'package:skf_project/features/recipe_temp/bloc/recipe_bloc.dart';
import 'package:skf_project/features/recipe_temp/pages/recipe_page.dart';
import 'package:skf_project/features/status/bloc/status_bloc.dart';
import 'package:skf_project/features/status/pages/status_page.dart';
import 'package:skf_project/core/mqtt/mqtt_client.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
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
          builder: (context) => BlocProvider(
            create: (context) =>
                RecipeBloc(mqttClientManager: MqttClientManager()),
            child: const RecipePage(),
          ),
        );
      case "/status":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => StatusBloc(
              mqttClientManager: MqttClientManager(),
            ),
            child: const StatusPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
