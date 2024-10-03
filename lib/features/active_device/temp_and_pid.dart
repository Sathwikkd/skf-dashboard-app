import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/mqtt_client.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperaturePidPage extends StatefulWidget {
  const TemperaturePidPage({super.key});

  @override
  State<TemperaturePidPage> createState() => _TemperaturePidPageState();
}

class _TemperaturePidPageState extends State<TemperaturePidPage> with SingleTickerProviderStateMixin {
  MQTTClientManager mqttClientManager = MQTTClientManager();
  double temperatureValue = 0.0;
  double pidvalveValue = 0.0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    if (temperatureValue >= 150) {
      _controller.repeat(reverse: true);
    }

    mqttClientManager.onMessageReceived = (String topic, String payload) {
      if (topic == 'vs24skf01/stream_temp') {
        setState(() {
          temperatureValue = double.parse(payload);
        });
      }
      if (topic == 'vs24skf01/stream_pid') {
        setState(() {
          pidvalveValue = double.parse(payload);
        });
      }
    };

    mqttClientManager.initializeMQTT();
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
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
        margin: const EdgeInsets.only(
          top: 5,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              20,
            ),
            topRight: Radius.circular(
              20,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Temperature",
                style: GoogleFonts.nunito(
                  color: Colors.grey.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(-6, 6),
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        spreadRadius: 1),
                    const BoxShadow(
                        offset: Offset(6, -6),
                        color: Colors.white,
                        blurRadius: 6,
                        spreadRadius: 1),
                  ],
                ),
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 200,
                      interval: 20,
                      showLastLabel: true,
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
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
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
              const SizedBox(
                height: 20,
              ),
              Text(
                "PID Valve Opening",
                style: GoogleFonts.nunito(
                  color: Colors.grey.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    const BoxShadow(
                        offset: Offset(6, -6),
                        color: Colors.white,
                        blurRadius: 6,
                        spreadRadius: 1),
                    BoxShadow(
                        offset: const Offset(-6, 6),
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        spreadRadius: 1),
                  ],
                ),
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 20,
                      interval: 5,
                      showLastLabel: true,
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
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
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
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
