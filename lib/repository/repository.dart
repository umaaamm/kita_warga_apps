import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/dashboard_response.dart';

class DashboardRepository {
  // final String apiKey = "";
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var getDashboard = '$mainUrl/api/admin/mock/data';

  Future<DashboardResponse> getDashboardRepository() async {
    try {
      Response response =
      await _dio.get(getDashboard);
      return DashboardResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DashboardResponse.withError("$error");
    }
  }

}