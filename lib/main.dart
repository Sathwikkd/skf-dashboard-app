import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skf_project/generated_routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async {
  final String token = await _initilize();
  runApp(MyApp(token: token,));
}

Future<String> _initilize() async {
    WidgetsFlutterBinding.ensureInitialized();
    final appDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    final box = await Hive.openBox("authtoken");
    var token = box.get('token');
    token ??= "";
    await box.close();
    return token;
}


class MyApp extends StatelessWidget {
  final String token;
  const MyApp({super.key , required this.token});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerate,
      initialRoute: token.isEmpty ? "/login" : "/drier",
    );
  }
}