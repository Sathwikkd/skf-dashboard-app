import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimeLine extends StatelessWidget {
  final double stepValue;
  final double stepCount;
  const TimeLine({super.key , required this.stepValue , required this.stepCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Linear Gauge
            Container(
              padding: const EdgeInsets.all(20),
              child: SfLinearGauge(
                showTicks: false,
                minimum: 1,
                maximum: stepCount,
                interval: 1,
                axisTrackStyle: LinearAxisTrackStyle(
                  color: Colors.grey.shade300,
                  thickness: 8,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                ),
                labelOffset: 10,
                markerPointers: [
                  for(double i = 1 ; i <= stepCount ; i++)
                    LinearShapePointer(
                      value: i,
                      shapeType: LinearShapePointerType.circle,
                      color: stepValue >= i? Colors.green: Colors.grey,
                      position: LinearElementPosition.cross,
                    ),
                ],
                axisLabelStyle: GoogleFonts.nunito(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onGenerateLabels: () {
                  return [
                    for(double i = 1 ; i <= stepCount ; i++)
                     LinearAxisLabel(text: "${i.toInt()}", value:i),
                  ];
                },
                barPointers:  [
                  LinearBarPointer(
                    value: stepValue, // Value for green progress bar
                    thickness: 8,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
