import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/common/loader/loader.dart';
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
    BlocProvider.of<RecipeBloc>(context).add(
      FetchRecipeEvent(
        drierId: widget.drierId,
      ),
    );
  }

//   {
// 	"rcp_stp":"1",
//   "rtm":"10",
//   "rtp":"30.90",
//   "stm":"60"
// }
  String Complete = "81";
  int stepCount = 0;
  double temperatureValue = 0;
  String timeValue = "00:00";
  String stepValue = "0";
  String stTime = "00:00";
  bool isConnected = false;

  String convertToTimeString(int? timeInSeconds) {
    if (timeInSeconds == null) return "00:00";

    // Convert seconds to hours and minutes
    int hours = timeInSeconds ~/ 60;
    int minutes = timeInSeconds % 60;

    // Format to "HH:mm" with leading zeros
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StepcountBloc, StepcountState>(listener: (context, state) {
          if (state is FetchStepCountSuccessState) {
            setState(() {
              stepCount = state.stepCount;
            });
          }
        }),
        BlocListener<RecipeBloc, RecipeState>(listener: (context, state) {
          if (state is FetchRecipeSuccessState) {
            setState(() {
              isConnected = true;
              // Update `stepValue` only if it is not null
              if (state.data.containsKey('rcp_stp') &&
                  state.data['rcp_stp'] != null) {
                stepValue = state.data['rcp_stp'];
              }

              // Update `temperatureValue` only if it is not null and can be parsed to double
              if (state.data.containsKey('rtp') && state.data['rtp'] != null) {
                double? newTemperature =
                    double.tryParse(state.data['rtp'].toString());
                if (newTemperature != null) {
                  temperatureValue = newTemperature;
                }
              }

              // Update `timeValue` only if it is not null
              // Usage
              if (state.data.containsKey('rtm') && state.data['rtm'] != null) {
                timeValue = convertToTimeString(state.data['rtm']);
              }

              if (state.data.containsKey('stm') && state.data['stm'] != null) {
                stTime = convertToTimeString(state.data['stm']);
              }
            });
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        appBar: AppBar(
          actions: [
            Icon(
              !isConnected
                  ? Icons.network_wifi_1_bar_sharp
                  : Icons.network_wifi_sharp,
              color: !isConnected ? Colors.red : Colors.green,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<StepcountBloc>(context).add(
                  FetchStepCount(
                    drierId: widget.drierId,
                  ),
                );
                BlocProvider.of<RecipeBloc>(context).add(
                  FetchRecipeEvent(
                    drierId: widget.drierId,
                  ),
                );
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<RecipeBloc>(context).add(
                StopRecipeFetchEvent(),
              );
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
          ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stTime,
                              style: GoogleFonts.nunito(
                                color: AppColors.darkGrey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              timeValue,
                              style: GoogleFonts.nunito(
                                color: AppColors.darkGrey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                  child: BlocBuilder<StepcountBloc, StepcountState>(
                    builder: (context, state) {
                      if (state is FetchStepCountSuccessState) {
                        return Center(
                          child: stepCount == 0
                              ? Center(
                                  child: Text(
                                    "No Steps to Display...",
                                    style: GoogleFonts.nunito(
                                      color: Colors.grey.shade600,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : TimeLine(
                                  stepValue: double.parse(stepValue),
                                  stepCount: stepCount.toDouble(),
                                ),
                        );
                      } else if (state is FetchStepCountLoadingState) {
                        return const Center(
                          child: Loader(),
                        );
                      } else if (state is FetchStepCointFailedState) {
                        return Center(
                          child: Text(
                            state.message,
                            style: GoogleFonts.nunito(
                              color: Colors.grey.shade600,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: Loader(),
                      );
                    },
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
                  child: BlocBuilder<StepcountBloc, StepcountState>(
                    builder: (context, state) {
                      if (state is FetchStepCountSuccessState) {
                        return Column(
                          mainAxisAlignment: stepCount == 0
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            stepCount != 0
                                ? Text(
                                    "Task List",
                                    style: GoogleFonts.nunito(
                                      color: Colors.grey.shade600,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 20,
                            ),
                            stepCount == 0
                                ? Center(
                                    child: Text(
                                      "No Steps to Display...",
                                      style: GoogleFonts.nunito(
                                        color: Colors.grey.shade600,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TaskElement(
                                              taskName: "Task ${index + 1}",
                                              completed: (int.parse(stepValue)  >
                                                      index + 1) || Complete == "400"
                                                  ? true
                                                  : false,
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
                        );
                      } else if (state is FetchStepCountLoadingState) {
                        return const Center(
                          child: Loader(),
                        );
                      } else if (state is FetchStepCointFailedState) {
                        return Center(
                          child: Text(
                            state.message,
                            style: GoogleFonts.nunito(
                              color: Colors.grey.shade600,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: Loader(),
                      );
                    },
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
