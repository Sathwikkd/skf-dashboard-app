
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';




class TemperatureStatus extends StatefulWidget {
  const TemperatureStatus({super.key});

  @override
  State<TemperatureStatus> createState() => _TemperatureStatusState();
}

class _TemperatureStatusState extends State<TemperatureStatus> with SingleTickerProviderStateMixin {
  double temperatureValue = 100.99; 

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
              'Real time temperature gauge',
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
                          widget: Text(
                            '${temperatureValue}°C', 
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
            if (temperatureValue >= 150)
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
