import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/karyawan/karyawan_response.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KaryawanRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var getKaryawanUrl = '$mainUrl/api/admin/list/karyawan';

  Future<KaryawanResponse> getListKaryawan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(getKaryawanUrl,
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      print(response);
      return KaryawanResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return KaryawanResponse.with401(AppConstant.msgIxpired);
        }
      }

      print("Exception occured: $error stackTrace: $stacktrace");
      return KaryawanResponse.withError("$error");
    }
  }
}