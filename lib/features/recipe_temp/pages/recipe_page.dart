import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/themes/constant_colors.dart';
import 'package:skf_project/core/widgets/guages/temperature_guage.dart';
import 'package:skf_project/features/recipe_temp/bloc/recipe_bloc.dart';
import 'package:skf_project/features/recipe_temp/widgets/task_element.dart';
import 'package:skf_project/features/recipe_temp/widgets/time_line.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  double temperatureValue = 0;
  String timeValue = "0";
  String task1 = "0";
  String task2 = "0";
  String task3 = "0";
  String task4 = "0";
  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeBloc, RecipeState>(
      listener: (context, state) {
        if (state is FetchRecipeSuccessState) {
          if (int.parse(state.data['tm']) < 60 &&
              int.parse(state.data["tm"]) != -1) {
            setState(() {
              timeValue = state.data["tm"];
            });
          }
          if (state.data['mt'] == "6") {
            setState(() {
              task1 = state.data["tm"];
            });
          } else if (state.data['mt'] == "7") {
            setState(() {
              task2 = state.data["tm"];
            });
          } else if (state.data['mt'] == "8") {
            setState(() {
              task3 = state.data["tm"];
            });
          } else if (state.data['mt'] == "9") {
            setState(() {
              task4 = state.data["tm"];
            });
          }
        }
      },
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
                          "00:00",
                          style: GoogleFonts.nunito(
                            color: AppColors.darkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            width: 280,
                            child: TemperatureGuage(
                              minimumTemp: 0,
                              maxTemp: 200,
                              interval: 20,
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
                    stepValue: task1 == "-1"
                        ? 1
                        : task2 == "-1"
                            ? 2
                            : task3 == "-1"
                                ? 3
                                : task4 == "-1"
                                    ? 4
                                    : 0,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TaskElement(
                          taskName: "Task 1",
                          completed: task1 == "-1" ? true : false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TaskElement(
                          taskName: "Task 2",
                          completed: task2 == "-1" ? true : false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TaskElement(
                          taskName: "Task 3",
                          completed: task3 == "-1" ? true : false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TaskElement(
                          taskName: "Task 4",
                          completed: task4 == "-1" ? true : false,
                        ),
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
      ),
    );
  }
}
