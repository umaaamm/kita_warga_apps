import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/kategori/kategori_response.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KategoriRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var getKategoryUrl = '$mainUrl/api/admin/list/kategori';

  Future<KategoriResponse> getListKategori() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(getKategoryUrl,
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));


      print(response);
      return KategoriResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return KategoriResponse.with401(AppConstant.msgIxpired);
        }
      }

      print("Exception occured: $error stackTrace: $stacktrace");
      return KategoriResponse.withError("$error");
    }
  }
}
