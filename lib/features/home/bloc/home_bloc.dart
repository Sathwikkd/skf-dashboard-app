import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<SubmitFeedbackEvent>((event, emit)async {
      if (event.message.isEmpty){
        emit(SubmitFeedbackFailureState(message: "Enter a Valid Feedback"));
        return;
      }
      try{
        emit(SubmitFeedbackLoadingState());
        final jsonBody = jsonEncode({
          'feedback':event.message,

        });
        var box = await Hive.openBox("authtoken");
        final String userid = box.get("user_id");
        box.close();
        final jsonResponse = await http.post(Uri.parse("https://skfplc.vsensetech.in/user/feedback/$userid"),
        body: jsonBody,
        );
        final response = jsonDecode(jsonResponse.body);

        if (jsonResponse.statusCode==200){
          emit(SubmitFeedbackSuccessState(message: 'Feedback submitted Successfully.'));
          return;
        }
        emit(SubmitFeedbackFailureState(message: 'Server Error'));

      }catch(e){
        emit(SubmitFeedbackFailureState(message: 'Application Error'));

      }
    });
  }
}
