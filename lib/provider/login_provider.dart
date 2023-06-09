import 'package:flutter/foundation.dart';
import 'package:kita_warga_apps/model/login.dart';
import 'package:kita_warga_apps/model/login_request.dart';
import 'package:kita_warga_apps/model/login_response.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  String? _token;
  late final SharedPreferences _preferences;
  final LoginRepository _repository = LoginRepository();

  String? get token => _token;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences.getString(AppConstant.accessToken);
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    // print(loginRequest);
    LoginResponse response = await _repository.getLogin(loginRequest);
    _token = response.login.accessToken;
    // print(response);
    if (response.login.accessToken.isNotEmpty) {
      saveSession(response.login);
    }
    notifyListeners();
    return response;
  }

  void saveSession(Login login) async {
    await _preferences.setString(AppConstant.accessToken, login.accessToken);
    await _preferences.setBool(AppConstant.isLogin, true);
  }

  Future<void> logout() async {
    _token = null;
    await _preferences.remove(AppConstant.accessToken);
    await _preferences.remove(AppConstant.isLogin);
    notifyListeners();
  }
}
