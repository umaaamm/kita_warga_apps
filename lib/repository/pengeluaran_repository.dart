import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_delete_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request_add.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request_update.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_response.dart';
import 'package:kita_warga_apps/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengeluaranRepository {
  static String mainUrl = "http://34.101.89.42:3000";
  final Dio _dio = Dio();
  var addPengeluaranUrl = '$mainUrl/api/admin/insert/pengeluaran';
  var getListPengeluaranUrl = '$mainUrl/api/admin/list/pengeluaran';
  var deletePengeluaranUrl = '$mainUrl/api/admin/delete/pengeluaran';
  var updatePengeluaranUrl = '$mainUrl/api/admin/update/pengeluaran';


  Future<GeneralResponsePost> addPengeluaran(PengeluaranRequestAdd pengeluaranRequestAdd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var params = {
        "id_transaksi": pengeluaranRequestAdd.id_transaksi,
        "nama_transaksi": pengeluaranRequestAdd.nama_transaksi,
        "id_kategori": pengeluaranRequestAdd.id_kategori,
        "tanggal_transaksi": pengeluaranRequestAdd.tanggal_transaksi,
        "nilai_transaksi": pengeluaranRequestAdd.nilai_transaksi,
        "keterangan": pengeluaranRequestAdd.keterangan,
        "bukti_foto": pengeluaranRequestAdd.bukti_foto,
        "id_kasbon": pengeluaranRequestAdd.id_kasbon,
        "id_perumahan": prefs.get(AppConstant.idPerumahan),
        "kategori_transaksi": pengeluaranRequestAdd.kategori_transaksi,
      };

      print(params);

      Response response = await _dio.post(addPengeluaranUrl,
          data: jsonEncode(params),
          options: Options(
              headers: {"x-access-token": prefs.get(AppConstant.accessToken)}));

      print(response);
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

  Future<GeneralResponsePost> updatePengeluaran(PengeluaranRequestUpdate pengeluaranRequestUpdate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var params = {
        "id_transaksi": pengeluaranRequestUpdate.pengeluaranRequestAdd.id_transaksi,
        "nama_transaksi": pengeluaranRequestUpdate.pengeluaranRequestAdd.nama_transaksi,
        "id_kategori": pengeluaranRequestUpdate.pengeluaranRequestAdd.id_kategori,
        "tanggal_transaksi": pengeluaranRequestUpdate.pengeluaranRequestAdd.tanggal_transaksi,
        "nilai_transaksi": pengeluaranRequestUpdate.pengeluaranRequestAdd.nilai_transaksi,
        "keterangan": pengeluaranRequestUpdate.pengeluaranRequestAdd.keterangan,
        "bukti_foto": pengeluaranRequestUpdate.pengeluaranRequestAdd.bukti_foto,
        "id_kasbon": pengeluaranRequestUpdate.pengeluaranRequestAdd.id_kasbon,
        "id_perumahan": prefs.get(AppConstant.idPerumahan),
        "kategori_transaksi": pengeluaranRequestUpdate.pengeluaranRequestAdd.kategori_transaksi,
      };

      Response response = await _dio.post(updatePengeluaranUrl,
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
