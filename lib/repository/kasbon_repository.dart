import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/kasbon/get_list_kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_delete_request.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon_response.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KasbonRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var addkasbonUrl = '$mainUrl/api/admin/insert/kasbon';
  var getListKasbonUrl = '$mainUrl/api/admin/list/kasbon';
  var deleteKasbonUrl = '$mainUrl/api/admin/delete/kasbon';
  // var updateWargaUrl = '$mainUrl/api/admin/update/warga';

  Future<ListKasbonResponse> getListKasbon(GetListKasbonRequest getListKasbonRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "id_perumahan": prefs.get(AppConstant.idPerumahan),
      "param": getListKasbonRequest.param,
      "nama" : getListKasbonRequest.nama
    };
    try {
      Response response = await _dio.post(getListKasbonUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      return ListKasbonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          return ListKasbonResponse.with401(AppConstant.msgIxpired);
        }
      }
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListKasbonResponse.withError("$error");
    }
  }

  Future<GeneralResponsePost> deleteKasbon(KasbonDeleteRequest kasbonDeleteRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "id_kasbon": kasbonDeleteRequest.id_kasbon,
    };
    try {
      Response response = await _dio.post(deleteKasbonUrl,
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

  Future<GeneralResponsePost> addKasbon(KasbonRequest kasbonRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var params = {
        "id_kasbon": kasbonRequest.id_kasbon,
        "nama_karyawan": kasbonRequest.nama_karyawan,
        "id_karyawan": kasbonRequest.id_karyawan,
        "detail_transaksi": kasbonRequest.detail_transaksi,
        "pinjaman": kasbonRequest.pinjaman,
        "tenor": kasbonRequest.tenor,
        "angsurang_per_bulan": kasbonRequest.angsuran_per_bulan,
        "keterangan": kasbonRequest.keterangan,
      };

      Response response = await _dio.post(addkasbonUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));
      print('object ini ${response}');
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
}
