
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ValveStatus extends StatefulWidget {
  const ValveStatus({super.key});

  @override
  State<ValveStatus> createState() => _ValveStatusState();
}

class _ValveStatusState extends State<ValveStatus> with SingleTickerProviderStateMixin {
  double valveValue = 18; 

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

    if (valveValue >= 15) {
      _controller.repeat(reverse: true); 
    }
  }

  @override
  void dispose() {
   
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PID valve opening',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 45),
            Center(
              child: SizedBox(
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 20,
                      interval: 1,
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
                          value: valveValue, 
                          enableAnimation: true,
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text(
                            '${valveValue}mA', 
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          positionFactor: 0.4,
                          angle: 90,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (valveValue >= 15)
              FadeTransition(
                opacity: _animation,
                child: const Icon(Icons.warning, color: Colors.red, size: 50),
              )
            else
              const Icon(Icons.warning, color: Colors.grey, size: 50), 
          ],
        ),
    );
  }
}
