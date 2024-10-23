import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureGuage extends StatelessWidget {
  final double minimumTemp;
  final double maxTemp;
  final double interval;
  final double temperatureValue;
  const TemperatureGuage({
    super.key,
    required this.minimumTemp,
    required this.maxTemp,
    required this.interval,
    this.temperatureValue = 0,
   });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: minimumTemp,
          maximum: maxTemp,
          interval: interval,
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }
}
