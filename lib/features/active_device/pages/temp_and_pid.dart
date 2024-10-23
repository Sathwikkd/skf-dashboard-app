import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/common/widgets/guages/pid_valve_guage.dart';
import 'package:skf_project/core/common/widgets/guages/temperature_guage.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';

class TemperaturePidPage extends StatefulWidget {
  const TemperaturePidPage({super.key});

  @override
  State<TemperaturePidPage> createState() => _TemperaturePidPageState();
}

class _TemperaturePidPageState extends State<TemperaturePidPage> {
  double temperatureValue = 0.0;
  double pidvalveValue = 0.0;

  @override
  void initState() {
    super.initState();
    // Fetching data from MQTT on init
    BlocProvider.of<TemperatureBloc>(context).add(FetchDataFromMqttEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: _appBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: BlocConsumer<TemperatureBloc, TemperatureState>(
            listener: (context, state) {
              if (state is FetchDataFromMqttSuccessState) {
                // Check topic and update state accordingly
                if (state.data['mt'] == "0") {
                  setState(() {
                    temperatureValue =
                        double.tryParse(state.data['tmp']) ?? 0.0;
                  });
                } else if (state.data['mt'] == "1") {
                  setState(() {
                    pidvalveValue = double.tryParse(state.data['pid']) ?? 0.0;
                  });
                } 
              }
            },
            builder: (context, state) {
              if (state is FetchDataFromMqttFailureState) {
                return Center(
                  child: Text(
                    'Failed to fetch data.',
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Temperature",
                    style: GoogleFonts.nunito(
                      color: Colors.grey.shade700,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _temperatureCard(),
                  const SizedBox(height: 20),
                  Text(
                    "PID Valve Opening",
                    style: GoogleFonts.nunito(
                      color: Colors.grey.shade700,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _pidCard(),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // App Bar Widget
  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<TemperatureBloc>(context).add(StopStreamEvent());
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      surfaceTintColor: Colors.blue.shade400,
      title: Text(
        "Real Time Data",
        style: GoogleFonts.nunito(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      backgroundColor: Colors.blue.shade400,
    );
  }

  // Temperature card widget
  Widget _temperatureCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-6, 6),
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 1,
          ),
          const BoxShadow(
            offset: Offset(6, -6),
            color: Colors.white,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TemperatureGuage(
        minimumTemp: 0,
        maxTemp: 200,
        interval: 20,
        temperatureValue: temperatureValue,
      ),
    );
  }

// Pid Valve widget card
  Widget _pidCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            offset: Offset(6, -6),
            color: Colors.white,
            blurRadius: 6,
            spreadRadius: 1,
          ),
          BoxShadow(
            offset: const Offset(-6, 6),
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: PidValveGuage(
        minimumVal: 0,
        interval: 5,
        maxVal: 20,
        pidValveOpening: pidvalveValue,
      ),
    );
  }
}
