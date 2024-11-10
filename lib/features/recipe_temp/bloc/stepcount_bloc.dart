

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:skf_project/core/constants/routes.dart';

part 'stepcount_event.dart';
part 'stepcount_state.dart';

class StepcountBloc extends Bloc<StepcountEvent, StepcountState> {
  StepcountBloc() : super(StepcountInitial()) {
    on<FetchStepCount>(_fetchStepCount);
  }

  Future<void> _fetchStepCount(FetchStepCount event  , Emitter<StepcountState> emit) async {
    try {
      if(event.drierId.isEmpty){
        emit(FetchStepCointFailedState(message: "Drier ID is Empty"));
      }
      final jsonResponse = await http.get(Uri.parse("${HttpRoutes.drierStepCount}/${event.drierId}"));
      final response = jsonDecode(jsonResponse.body);
      print(response);
      if(jsonResponse.statusCode == 200){
        print('yes');
        emit(FetchStepCountSuccessState(stepCount: response["recipe_step_count"]));
        return;
      }
      emit(FetchStepCointFailedState(message: "Server Error"));
    } catch (e) {
      emit(FetchStepCointFailedState(message: "Application Error"));
    }
  }
}
