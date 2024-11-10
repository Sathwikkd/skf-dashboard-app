import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skf_project/core/constants/routes.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_authLoginEvent);
    on<AuthLogoutEvent>(_authLogoutEvent);
  }

  _authLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    // Verification and Validation
    if (event.email.isEmpty && event.password.isEmpty) {
      emit(AuthFailedState(message: "Enter Valid Credentials"));
    }

    // The Login Process
    try {
      emit(AuthLoadingState());
      final requestBody = jsonEncode({
        "email": event.email,
        "password": event.password,
      });
      final jsonResponse = await http.post(Uri.parse(HttpRoutes.loginUser), body: requestBody);
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode == 200) {
        var box = await Hive.openBox("authtoken");
        var tokenData = JwtDecoder.decode(response['token']);
        box.put("token", response['token']);
        box.put("user_id", tokenData['user_id']);
        box.put("name", tokenData['label']);
        box.close();
        emit(AuthSuccessState());
        return;
      }
      emit(AuthFailedState(message: response['message']));
    } catch (e) {
      emit(AuthFailedState(message: "Application Error"));
    }
  }
  
  Future<void> _authLogoutEvent(AuthLogoutEvent event , Emitter<AuthState> emit) async {
    try{
      final box = await Hive.openBox("authtoken");
      box.delete("token");
      box.delete("user_id");
      box.delete("name");
      box.close();
      emit(AuthLogoutSuccessState());
    }catch(e){
      emit(AuthLogouteFailedState(message: e.toString()));
    }
  }
}
