import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/login/login_request.dart';
import 'package:kita_warga_apps/model/login/login_response.dart';
import 'package:kita_warga_apps/repository/login_repository.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockPreference {
  String? _token;
  String? _idPerumahan;
  String? _idPerngurus;
  String? _idWarga;
  late final SharedPreferences _preferences;
  String? get token => _token;
  String? get idPerumahan => _idPerumahan;
  String? get idPengurus => _idPerngurus;
  String? get idWarga => _idWarga;

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

  Future<void> getDataAccount() async {
    _preferences = await SharedPreferences.getInstance();
    _idWarga = _preferences.getString(AppConstant.idWarga);
    _idPerumahan = _preferences.getString(AppConstant.idPerumahan);
    _idPerngurus = _preferences.getString(AppConstant.idPengurus);
  }
}
