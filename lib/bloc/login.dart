import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kita_warga_apps/model/dashboard_response.dart';
import 'package:kita_warga_apps/model/login_request.dart';
import 'package:kita_warga_apps/model/login_response.dart';
import 'package:kita_warga_apps/pages/home_page.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';
import 'package:kita_warga_apps/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final LoginRepository _repository = LoginRepository();
  final BehaviorSubject<LoginResponse> _subject =
      BehaviorSubject<LoginResponse>();

  doLoagin(LoginRequest loginRequest) async {
    LoginResponse response = await _repository.getLogin(loginRequest);
    saveSession(response);
    _subject.sink.add(response);

    // if(response.login.accessToken != null){
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return HomePages();
    //       },
    //     ),
    //   );
    // }
  }

  void saveSession(LoginResponse loginResponse) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("accessToken", loginResponse.login.accessToken);
    await pref.setBool("is_login", true);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<LoginResponse> get subject => _subject;
}

final loginBloc = LoginBloc();
