import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/features/active_device/bloc/temperature_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
      appBar: AppBar(
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
      ),
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
                print(state.data['message_type']);
                if (state.data['message_type'] == 0) {
                  setState(() {
                    temperatureValue = double.tryParse(state.data['temp']) ?? 0.0;
                  });
                } else if (state.data['message_type'] == 1) {
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
                  Container(
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
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 200,
                          interval: 20,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 50,
                              color: Colors.green,
                            ),
                            GaugeRange(
                              startValue: 50,
                              endValue: 100,
                              color: Colors.orange,
                            ),
                            GaugeRange(
                              startValue: 100,
                              endValue: 150,
                              color: Colors.yellow,
                            ),
                            GaugeRange(
                              startValue: 150,
                              endValue: 200,
                              color: Colors.red,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: temperatureValue,
                              enableAnimation: true,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    const BoxShadow(
                                      offset: Offset(4, -4),
                                      color: Colors.white,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      offset: const Offset(-4, 4),
                                      color: Colors.grey.shade200,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '${temperatureValue.toStringAsFixed(2)}°C',
                                  style: GoogleFonts.nunito(
                                    color: Colors.grey.shade800,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              positionFactor: 0.8,
                              angle: 90,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  Container(
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
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 20,
                          interval: 5,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 5,
                              color: Colors.green,
                            ),
                            GaugeRange(
                              startValue: 5,
                              endValue: 10,
                              color: Colors.orange,
                            ),
                            GaugeRange(
                              startValue: 10,
                              endValue: 15,
                              color: Colors.yellow,
                            ),
                            GaugeRange(
                              startValue: 15,
                              endValue: 20,
                              color: Colors.red,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: pidvalveValue,
                              enableAnimation: true,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    const BoxShadow(
                                      offset: Offset(4, -4),
                                      color: Colors.white,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      offset: const Offset(-4, 4),
                                      color: Colors.grey.shade200,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '${pidvalveValue.toStringAsFixed(2)}mA',
                                  style: GoogleFonts.nunito(
                                    color: Colors.grey.shade800,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              positionFactor: 0.8,
                              angle: 90,
                            ),
                          ],
                        ),
                      ],
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
}
