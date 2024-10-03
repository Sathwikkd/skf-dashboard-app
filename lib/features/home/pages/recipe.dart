import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skf_project/components/timeline.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerClockPage extends StatefulWidget {
  @override
  _TimerClockPageState createState() => _TimerClockPageState();
}

class _TimerClockPageState extends State<TimerClockPage> {
  int currentStep = 0; 
  Timer? _timer; 
  final int stepDuration = 5; 
  int currentSeconds = 0;
  final int totalSteps = 4; 

  
  String get timerText {
    int secondsRemaining = stepDuration - currentSeconds;
    return '${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')}';
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1),
     (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (currentSeconds >= stepDuration) {
          _moveToNextStep(); 
        }
      });
    });
  }

  void resetTimer() {
    _timer?.cancel(); 
    currentSeconds = 0; 
    startTimer(); 
  }

  void _showCompletionReport() {
    _timer?.cancel(); 
    setState(() {
      currentSeconds = 0;  
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text("Completion Report"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("All steps completed successfully!"),
             const SizedBox(height: 10),
             const Text("Status: Completed"),
             const SizedBox(height: 10),
              Text("Report Generated: ${DateTime.now()}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _moveToNextStep() {
    setState(() {
      if (currentStep < totalSteps) {
        currentStep++;
        if (currentStep == totalSteps) {
          _showCompletionReport();  
        } else {
          resetTimer(); 
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();  
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
        title: const Text('Automatic Timeline with Timer'),
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
                              value: 160,
                              enableAnimation: true,
                            ),
                          ],
                          annotations: const <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                '160°C',
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
              children: [
                MyTimeLine(
                  isFirst: true,
                  isLast: false,
                  isPast: currentStep >= 1,
                  eventcard: const Text('1st step completed'),
                ),
                MyTimeLine(
                  isFirst: false,
                  isLast: false,
                  isPast: currentStep >= 2,
                  eventcard: const Text('2nd task completed'),
                ),
                MyTimeLine(
                  isFirst: false,
                  isLast: false,
                  isPast: currentStep >= 3,
                  eventcard:const Text('3rd step completed'),
                ),
                MyTimeLine(
                  isFirst: false,
                  isLast: true,
                  isPast: currentStep >= 4,
                  eventcard: const Text('Final step completed'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
