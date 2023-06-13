import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/model/dashboard/dashboard_response.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var getDashboard = '$mainUrl/api/admin/mock/data';
  var getDashboardLastTrx = '$mainUrl/api/admin/mock/datalist';

  Future<DashboardResponse> getDashboardRepository() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await _dio.get(getDashboard,
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      if (response.statusCode == 401) {
        return DashboardResponse.with401(AppConstant.msgIxpired);
      }

      return DashboardResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return DashboardResponse.with401(AppConstant.msgIxpired);
        }
      }

      print("Exception occured: $error stackTrace: $stacktrace");
      return DashboardResponse.withError("$error");
    }
  }

  Future<DashboardLastTrxResponse> getDashboardLastTrxRepository() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(getDashboardLastTrx,
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      return DashboardLastTrxResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return DashboardLastTrxResponse.with401(AppConstant.msgIxpired);
        }
      }

      print("Exception occured: $error stackTrace: $stacktrace");
      return DashboardLastTrxResponse.withError("$error");
    }
  }
}
