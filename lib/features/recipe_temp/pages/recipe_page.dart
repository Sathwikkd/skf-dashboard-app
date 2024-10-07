import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/features/recipe_temp/widgets/task_element.dart';
import 'package:skf_project/features/recipe_temp/widgets/time_line.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final double temperatureValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        title: Text(
          "Recipe Page",
          style: GoogleFonts.nunito(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade400,
        surfaceTintColor: Colors.blue.shade400,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              10,
            ),
            topRight: Radius.circular(
              10,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 408,
                width: MediaQuery.of(context).size.width - 40,
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
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "00:00",
                        style: GoogleFonts.nunito(
                          color: Colors.grey.shade600,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 280,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
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
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 105,
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
                width: MediaQuery.of(context).size.width - 40,
                child:const TimeLine(
                  stepValue: 2,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 400,
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Task List",
                        style: GoogleFonts.nunito(
                          color: Colors.grey.shade600,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const TaskElement(taskName: "Task 1",completed: true,),
                      const SizedBox(height: 20,),
                      const TaskElement(taskName: "Task 2",completed: true,),
                      const SizedBox(height: 20,),
                      const TaskElement(taskName: "Task 3",completed: false,),
                      const SizedBox(height: 20,),
                      const TaskElement(taskName: "Task 4",completed: false,),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
