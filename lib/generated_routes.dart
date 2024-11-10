import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';
import 'package:skf_project/features/active_device/pages/temp_and_pid.dart';
import 'package:skf_project/features/auth/pages/login_page.dart';
import 'package:skf_project/features/drier_selection/bloc/drier_bloc.dart';
import 'package:skf_project/features/drier_selection/pages/drier_selection_page.dart';
import 'package:skf_project/features/home/pages/home_page.dart';
import 'package:skf_project/features/recipe_temp/bloc/recipe_bloc.dart';
import 'package:skf_project/features/recipe_temp/bloc/stepcount_bloc.dart';
import 'package:skf_project/features/recipe_temp/pages/recipe_page.dart';
import 'package:skf_project/features/status/bloc/status_bloc.dart';
import 'package:skf_project/features/status/pages/status_page.dart';
import 'package:skf_project/core/mqtt/mqtt_client.dart';

import 'features/auth/bloc/auth_bloc.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    // Extract arguments if needed
    final args = settings.arguments;

    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(),
            child: const LoginPage(),
          ),
        );
      case "/home":
        if (args is Arguments) {
          return MaterialPageRoute(
            builder: (context) =>
                HomePage(drierId: args.drierId, plcId: args.plcId),
          );
        }
      case "/temp":
      if(args is Arguments){
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                TemperatureBloc(mqttClientManager: MqttClientManager()),
            child:  TemperaturePidPage(drierId: args.drierId , plcId: args.plcId,),
          ),
        );
      }
      case "/recipe":
        if (args is Arguments) {
          return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => RecipeBloc(
                    mqttClientManager: MqttClientManager(),
                  ),
                ),
                BlocProvider(
                  create: (context) => StepcountBloc(),
                ),
              ],
              child: RecipePage(
                drierId: args.drierId,
                plcId: args.plcId,
              ),
            ),
          );
        }
      case "/status":
        if (args is Arguments) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => StatusBloc(
                mqttClientManager: MqttClientManager(),
              ),
              child: StatusPage(
                drierId: args.drierId,
                plcId: args.plcId,
              ),
            ),
          );
        }
      case "/drier":
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DrierBloc()),
              BlocProvider(create: (context) => AuthBloc()),
            ],
            child: const DrierSelectionPage(),
          ),
        );
    }
  }
}
