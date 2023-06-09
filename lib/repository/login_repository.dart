import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/model/dashboard_response.dart';
import 'package:kita_warga_apps/model/login_request.dart';
import 'package:kita_warga_apps/model/login_response.dart';

class LoginRepository {
  // final String apiKey = "";
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var login = '$mainUrl/api/auth/signin';


  Future<LoginResponse> getLogin(LoginRequest loginRequest) async {
    try {
      var params =  {
        "email_admin": loginRequest.email_admin,
        "password_admin": loginRequest.password_admin,
      };
      Response response =
      await _dio.post(login, data: jsonEncode(params),);
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError("$error");
    }
  }

}