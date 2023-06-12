import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/list_warga_response.dart';
import 'package:kita_warga_apps/model/warga_request.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WargaRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var addWargaUrl = '$mainUrl/api/admin/insert/warga';
  var getListWargaUrl = '$mainUrl/api/admin/list/warga';

  Future<GeneralResponsePost> addWarga(WargaRequest wargaRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var params = {
        "id_warga": wargaRequest.id_warga,
        "nama_warga": wargaRequest.nama_warga,
        "blok_rumah": wargaRequest.blok_rumah,
        "nomor_rumah": wargaRequest.nomor_rumah,
        "email": wargaRequest.email,
        "nomor_hp": wargaRequest.nomor_hp,
        "is_rw": wargaRequest.is_rw,
        "is_rt": wargaRequest.is_rt,
        "id_rt": wargaRequest.id_rt,
        "id_rw": wargaRequest.id_rw,
        "id_perumahan": wargaRequest.id_perumahan,
        "status_pernikahan": wargaRequest.status_pernikahan,
        "jenis_kelamin": wargaRequest.jenis_kelamin,
      };

      Response response = await _dio.post(addWargaUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));
      return GeneralResponsePost.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GeneralResponsePost.withError("$error");
    }
  }

  Future<ListWargaResponse> getListWarga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params =  {
      "id_perumahan": prefs.get(AppConstant.idPerumahan),
    };
    try {
      Response response = await _dio.post(getListWargaUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));
      return ListWargaResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListWargaResponse.withError("$error");
    }
  }


}
