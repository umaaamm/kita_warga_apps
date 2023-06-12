import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/login_request.dart';
import 'package:kita_warga_apps/model/login_response.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockPreference {
  String? _token;
  late final SharedPreferences _preferences;
  String? get token => _token;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences.getString(AppConstant.accessToken);
  }

  Future<void> logout() async {
    _token = null;
    _preferences = await SharedPreferences.getInstance();
    await _preferences.remove(AppConstant.accessToken);
    await _preferences.remove(AppConstant.isLogin);
  }
}
