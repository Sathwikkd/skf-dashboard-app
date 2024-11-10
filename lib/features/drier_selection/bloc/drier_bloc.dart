
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/core/constants/routes.dart';

part 'drier_event.dart';
part 'drier_state.dart';

class DrierBloc extends Bloc<DrierEvent, DrierState> {
  DrierBloc() : super(DrierInitial()) {
    on<FetchAllDriersEvent>(_fetchAllDriersEvent);
  }
  Future<void> _fetchAllDriersEvent(FetchAllDriersEvent event , Emitter<DrierState> emit) async {
    try{
      emit(DrierFetchLoadingState());
      final box = await Hive.openBox("authtoken");
      final String userId = await box.get("user_id");
      box.close();
      final jsonResponse = await http.get(Uri.parse("${HttpRoutes.driersFetch}/$userId"));
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode == 200) {
        if(response['driers'] == null){
          emit(DrierFetchFailedState(message: "No Drier Exist" , errCode: 1));
          return;
        }
        emit(DrierFetchSuccessState(data: response['driers']));
        return;
      }
      emit(DrierFetchFailedState(message: response['message'] , errCode: 2));
    }catch(e){
      emit(DrierFetchFailedState(message: "Application Error" , errCode: 3));
    }
  }
}
