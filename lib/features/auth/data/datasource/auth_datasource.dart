import "dart:convert";
import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import "package:skf_project/core/error/exceptions.dart";

abstract interface class AuthDatasource {
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthDatasuorceImpl extends AuthDatasource {
  final String url;
  AuthDatasuorceImpl({required this.url});
  @override
  Future<String> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      var jsonResponse = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      var response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode == 200) {
        var box = await Hive.openBox("auth");
        box.put("token", response["token"]);
        box.close();
        return "Login Successfull";
      }
      throw ServerException(response['message']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
