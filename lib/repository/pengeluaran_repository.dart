import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_delete_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_response.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengeluaranRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var addPengeluaranUrl = '$mainUrl/api/admin/insert/pengeluaran';
  var getListPengeluaranUrl = '$mainUrl/api/admin/list/pengeluaran';
  var deletePengeluaranUrl = '$mainUrl/api/admin/delete/pengeluaran';
  var upatePengeluaranUrl = '$mainUrl/api/admin/update/pengeluaran';


  // Future<GeneralResponsePost> addPengeluaran(WargaRequest wargaRequest) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   try {
  //     var params = {
  //       "id_warga": wargaRequest.id_warga,
  //       "nama_warga": wargaRequest.nama_warga,
  //       "blok_rumah": wargaRequest.blok_rumah,
  //       "nomor_rumah": wargaRequest.nomor_rumah,
  //       "email": wargaRequest.email,
  //       "nomor_hp": wargaRequest.nomor_hp,
  //       "is_rw": wargaRequest.is_rw,
  //       "is_rt": wargaRequest.is_rt,
  //       "id_rt": wargaRequest.id_rt,
  //       "id_rw": wargaRequest.id_rw,
  //       "id_perumahan": wargaRequest.id_perumahan,
  //       "status_pernikahan": wargaRequest.status_pernikahan,
  //       "jenis_kelamin": wargaRequest.jenis_kelamin,
  //     };
  //
  //     Response response = await _dio.post(addWargaUrl,
  //         data: jsonEncode(params),
  //         options: Options(
  //             headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));
  //     return GeneralResponsePost.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     if (error is DioError) {
  //       if (error.response?.statusCode == 401) {
  //         return GeneralResponsePost.with401(AppConstant.msgIxpired);
  //       }
  //     }
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return GeneralResponsePost.withError("$error");
  //   }
  // }
  //
  // Future<GeneralResponsePost> updateWarga(WargaRequestUpdate wargaRequestUpdate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     var params = {
  //       "id_warga": wargaRequestUpdate.wargaRequest.id_warga,
  //       "nama_warga": wargaRequestUpdate.wargaRequest.nama_warga,
  //       "blok_rumah": wargaRequestUpdate.wargaRequest.blok_rumah,
  //       "nomor_rumah": wargaRequestUpdate.wargaRequest.nomor_rumah,
  //       "email": wargaRequestUpdate.wargaRequest.email,
  //       "nomor_hp": wargaRequestUpdate.wargaRequest.nomor_hp,
  //       "is_rw": wargaRequestUpdate.wargaRequest.is_rw,
  //       "is_rt": wargaRequestUpdate.wargaRequest.is_rt,
  //       "id_rt": wargaRequestUpdate.wargaRequest.id_rt,
  //       "id_rw": wargaRequestUpdate.wargaRequest.id_rw,
  //       "id_perumahan": wargaRequestUpdate.wargaRequest.id_perumahan,
  //       "status_pernikahan": wargaRequestUpdate.wargaRequest.status_pernikahan,
  //       "jenis_kelamin": wargaRequestUpdate.wargaRequest.jenis_kelamin,
  //     };
  //
  //     Response response = await _dio.post(updateWargaUrl,
  //         data: jsonEncode(params),
  //         options: Options(
  //             headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));
  //     return GeneralResponsePost.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     if (error is DioError) {
  //       if (error.response?.statusCode == 401) {
  //         return GeneralResponsePost.with401(AppConstant.msgIxpired);
  //       }
  //     }
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return GeneralResponsePost.withError("$error");
  //   }
  // }

  Future<PengeluaranResponse> getListPengeluaran(GetListPengeluaranRequest getListPengeluaranRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "id_perumahan": prefs.get(AppConstant.idPerumahan),
      "param": getListPengeluaranRequest.param,
      "pengeluaran" : getListPengeluaranRequest.pengeluaran
    };
    try {
      Response response = await _dio.post(getListPengeluaranUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      return PengeluaranResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return PengeluaranResponse.with401(AppConstant.msgIxpired);
        }
      }
      print("Exception occured: $error stackTrace: $stacktrace");
      return PengeluaranResponse.withError("$error");
    }
  }

  Future<GeneralResponsePost> deletePengeluaran(
      PengeluaranDeleteRequest pengeluaranDeleteRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "id_transaksi": pengeluaranDeleteRequest.id_transaksi,
    };
    try {
      Response response = await _dio.post(deletePengeluaranUrl,
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
