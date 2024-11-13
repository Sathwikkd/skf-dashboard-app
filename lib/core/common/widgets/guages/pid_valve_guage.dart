import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PidValveGuage extends StatelessWidget {
  final double minimumVal;
  final double maxVal;
  final double interval;
  final double pidValveOpening;
  const PidValveGuage({
    super.key,
    required this.minimumVal,
    required this.interval,
    required this.maxVal,
    this.pidValveOpening = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: minimumVal,
          maximum:maxVal,
          interval: interval,
          showLastLabel: true,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 25,
              color: Colors.green,
            ),
            GaugeRange(
              startValue: 25,
              endValue: 50,
              color: Colors.orange,
            ),
            GaugeRange(
              startValue: 50,
              endValue: 75,
              color: Colors.yellow,
            ),
            GaugeRange(
              startValue: 75,
              endValue: 100,
              color: Colors.red,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: pidValveOpening,
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
                  '${pidValveOpening.toStringAsFixed(2)}%',
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
