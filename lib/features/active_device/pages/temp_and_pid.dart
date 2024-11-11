import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/common/widgets/guages/pid_valve_guage.dart';
import 'package:skf_project/core/common/widgets/guages/temperature_guage.dart';
import 'package:skf_project/core/common/widgets/indications/snackbar.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';

class TemperaturePidPage extends StatefulWidget {
  final String drierId;
  final String plcId;
  const TemperaturePidPage({
    super.key,
    required this.drierId,
    required this.plcId,
  });

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
    BlocProvider.of<TemperatureBloc>(context).add(
      FetchDataFromMqttEvent(
        drierId: widget.drierId,
      ),
    );
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
            /// [Bloc Listeners Here]
            listener: (context, state) {
              /// [FetchDataFromMqttSuccessState]
              if (state is FetchDataFromMqttSuccessState) {
                setState(() {
                  // Update `temperatureValue` only if a valid value is received
                  if (state.data.containsKey('rt_tp') &&
                      state.data['rt_tp'] != null) {
                    double? newTemperature =
                        double.tryParse(state.data['rt_tp'].toString());
                    if (newTemperature != null) {
                      temperatureValue = newTemperature;
                    }
                  }
                  // Update `pidvalveValue` only if a valid value is received
                  if (state.data.containsKey('rt_pid') &&
                      state.data['rt_pid'] != null) {
                    double? newPidValve =
                        double.tryParse(state.data['rt_pid'].toString());
                    if (newPidValve != null) {
                      pidvalveValue = newPidValve;
                    }
                  }
                });
              }
              /// [FetchDataFromMqttFailedState]
              if (state is FetchDataFromMqttFailureState) {
                Snackbar.showSnackbar(
                  message: state.message,
                  leadingIcon: Icons.error,
                  context: context,
                );
              }
            },
            /// [Bloc Builder Here]
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  _customCard(
                    label: "Temperature",
                    child: TemperatureGuage(
                      minimumTemp: 0,
                      maxTemp: 200,
                      interval: 20,
                      temperatureValue: temperatureValue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _customCard(
                    label: "PID Valve Opening",
                    child: PidValveGuage(
                      minimumVal: 0,
                      interval: 5,
                      maxVal: 20,
                      pidValveOpening: pidvalveValue,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// [AppBar] widget
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

  /// [Temperature] and [PID] Neomorphic Card
  Widget _customCard({required Widget child, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-6, 6),
            color: Colors.grey.shade300,
            blurRadius: 4,
            spreadRadius: 0,
          ),
          const BoxShadow(
            offset: Offset(6, -6),
            color: Colors.white,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            label,
            style: GoogleFonts.nunito(
              color: Colors.grey.shade700,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
