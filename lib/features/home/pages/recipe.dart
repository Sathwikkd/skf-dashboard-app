import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skf_project/components/timeline.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerClockPage extends StatefulWidget {
  @override
  _TimerClockPageState createState() => _TimerClockPageState();
}

class _TimerClockPageState extends State<TimerClockPage> {
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;
  Timer? _timer;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void startTimeout() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Recipe Timer and Temperature'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 220,
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
                          pointers: const <GaugePointer>[
                            NeedlePointer(
                              value: 100,
                              enableAnimation: true,
                            ),
                          ],
                          annotations: const <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                '100°C',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              positionFactor: 0.4,
                              angle: 90,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        timerText,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children:const [
                MyTimeLine(isFirst: true, isLast: false, isPast: true,eventcard: Text('1st step completed'),),
                MyTimeLine(isFirst: false, isLast: false, isPast: true,eventcard: Text('2nd task completed'),),
                MyTimeLine(isFirst: false, isLast: false, isPast: true,eventcard: Text('3rd step completed'),),
                MyTimeLine(isFirst: false, isLast: true, isPast: true,eventcard: Text('final step completed'),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
