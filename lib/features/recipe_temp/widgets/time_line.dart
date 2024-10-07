import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimeLine extends StatelessWidget {
  final double stepValue;
  const TimeLine({super.key , required this.stepValue});

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
                maximum: 4,
                interval: 1,
                axisTrackStyle: LinearAxisTrackStyle(
                  color: Colors.grey.shade300,
                  thickness: 8,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                ),
                labelOffset: 10,
                markerPointers: [
                  LinearShapePointer(
                    value: 1,
                    shapeType: LinearShapePointerType.circle,
                    color: stepValue >= 1? Colors.green: Colors.grey,
                    position: LinearElementPosition.cross,
                  ),
                  LinearShapePointer(
                    value: 2,
                    shapeType: LinearShapePointerType.circle,
                    color: stepValue >= 2 ? Colors.green: Colors.grey,
                    position: LinearElementPosition.cross,
                  ),
                  LinearShapePointer(
                    value: 3,
                    shapeType: LinearShapePointerType.circle,
                    color: stepValue >= 3 ?Colors.green : Colors.grey,
                    position: LinearElementPosition.cross,
                  ),
                  LinearShapePointer(
                    value: 4,
                    shapeType: LinearShapePointerType.circle,
                    color: stepValue >= 4 ?Colors.green : Colors.grey,
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
                    const LinearAxisLabel(text: "1", value: 1),
                    const LinearAxisLabel(text: "2", value: 2),
                    const LinearAxisLabel(text: "3", value: 3),
                    const LinearAxisLabel(text: "4", value: 4),
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
