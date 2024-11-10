import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/themes/constant_colors.dart';
import 'package:skf_project/core/common/widgets/guages/temperature_guage.dart';
import 'package:skf_project/features/recipe_temp/bloc/recipe_bloc.dart';
import 'package:skf_project/features/recipe_temp/bloc/stepcount_bloc.dart';
import 'package:skf_project/features/recipe_temp/widgets/task_element.dart';
import 'package:skf_project/features/recipe_temp/widgets/time_line.dart';

class RecipePage extends StatefulWidget {
  final String drierId;
  final String plcId;
  const RecipePage({
    super.key,
    required this.drierId,
    required this.plcId,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StepcountBloc>(context).add(
      FetchStepCount(
        drierId: widget.drierId,
      ),
    );
  }

  int stepCount = 2;
  double temperatureValue = 0;
  String timeValue = "00:00";
  String task1 = "0";
  String task2 = "0";
  String task3 = "0";
  String task4 = "0";
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StepcountBloc , StepcountState>(listener: (context , state) {
          if(state is FetchStepCountSuccessState){
            // setState(() {
            //   stepCount = state.stepCount;
            // });
          }
        }),
        BlocListener<RecipeBloc , RecipeState>(listener: (context , state) {

        }),
      ],
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        appBar: AppBar(
          title: Text(
            "Recipe Page",
            style: GoogleFonts.nunito(
              color: AppColors.whiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.lightBlue,
          surfaceTintColor: AppColors.lightBlue,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
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
                  height: 420,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(-6, 6),
                        color: AppColors.mediumGrey,
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        offset: Offset(6, -6),
                        color: AppColors.whiteColor,
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
                          timeValue,
                          style: GoogleFonts.nunito(
                            color: AppColors.darkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 280,
                            child: TemperatureGuage(
                              minimumTemp: 0,
                              maxTemp: 200,
                              interval: 20,
                              temperatureValue: temperatureValue,
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
                  child: TimeLine(
                    stepValue: 3,
                    stepCount: stepCount.toDouble(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Task List",
                        style: GoogleFonts.nunito(
                          color: Colors.grey.shade600,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                TaskElement(
                                  taskName: "Task $index",
                                  completed: task1 == "-1" ? true : false,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                          itemCount: stepCount,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
