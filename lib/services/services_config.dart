import 'package:dio/dio.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesCongfig {
  dynamic requestInterceptor(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(AppConstant.accessToken);
    options.headers.addAll({"x-access-token": token});
    return options;
  }
}