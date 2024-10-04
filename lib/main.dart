import 'package:flutter/material.dart';
import 'package:skf_project/features/active_device/temp_and_pid.dart';
import 'package:skf_project/features/home/pages/home_page.dart';
import 'package:skf_project/generated_routes.dart';


void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerate,
      initialRoute: "/temp",
    );
  }
}