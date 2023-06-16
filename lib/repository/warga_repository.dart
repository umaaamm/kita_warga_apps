import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/model/warga/list_warga_response.dart';
import 'package:kita_warga_apps/model/warga/warga_delete_request.dart';
import 'package:kita_warga_apps/model/warga/warga_request.dart';
import 'package:kita_warga_apps/model/warga/warga_request_update.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WargaRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var addWargaUrl = '$mainUrl/api/admin/insert/warga';
  var getListWargaUrl = '$mainUrl/api/admin/list/warga';
  var deleteWargaUrl = '$mainUrl/api/admin/delete/warga';
  var updateWargaUrl = '$mainUrl/api/admin/update/warga';


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
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return GeneralResponsePost.with401(AppConstant.msgIxpired);
        }
      }
      print("Exception occured: $error stackTrace: $stacktrace");
      return GeneralResponsePost.withError("$error");
    }
  }

  Future<GeneralResponsePost> updateWarga(WargaRequestUpdate wargaRequestUpdate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var params = {
        "id_warga": wargaRequestUpdate.wargaRequest.id_warga,
        "nama_warga": wargaRequestUpdate.wargaRequest.nama_warga,
        "blok_rumah": wargaRequestUpdate.wargaRequest.blok_rumah,
        "nomor_rumah": wargaRequestUpdate.wargaRequest.nomor_rumah,
        "email": wargaRequestUpdate.wargaRequest.email,
        "nomor_hp": wargaRequestUpdate.wargaRequest.nomor_hp,
        "is_rw": wargaRequestUpdate.wargaRequest.is_rw,
        "is_rt": wargaRequestUpdate.wargaRequest.is_rt,
        "id_rt": wargaRequestUpdate.wargaRequest.id_rt,
        "id_rw": wargaRequestUpdate.wargaRequest.id_rw,
        "id_perumahan": wargaRequestUpdate.wargaRequest.id_perumahan,
        "status_pernikahan": wargaRequestUpdate.wargaRequest.status_pernikahan,
        "jenis_kelamin": wargaRequestUpdate.wargaRequest.jenis_kelamin,
      };

      Response response = await _dio.post(updateWargaUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));
      return GeneralResponsePost.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return GeneralResponsePost.with401(AppConstant.msgIxpired);
        }
      }
      print("Exception occured: $error stackTrace: $stacktrace");
      return GeneralResponsePost.withError("$error");
    }
  }



  Future<ListWargaResponse> getListWarga(GetListWargaRequest getListWargaRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "id_perumahan": prefs.get(AppConstant.idPerumahan),
      "param": getListWargaRequest.param,
      "nama" : getListWargaRequest.nama
    };
    try {
      Response response = await _dio.post(getListWargaUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      return ListWargaResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return ListWargaResponse.with401(AppConstant.msgIxpired);
        }
      }
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListWargaResponse.withError("$error");
    }
  }

  Future<GeneralResponsePost> deleteWarga(
      WargaDeleteRequest wargaDeleteRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "id_warga": wargaDeleteRequest.id_warga,
    };
    try {
      Response response = await _dio.post(deleteWargaUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      if (response.statusCode == 401) {
        return GeneralResponsePost.with401(AppConstant.msgIxpired);
      }

      return GeneralResponsePost.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return GeneralResponsePost.with401(AppConstant.msgIxpired);
        }
      }
      print("Exception occured: $error stackTrace: $stacktrace");
      return GeneralResponsePost.withError("$error");
    }
  }
}
