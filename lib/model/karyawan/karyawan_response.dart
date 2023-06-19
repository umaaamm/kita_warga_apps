import 'package:kita_warga_apps/model/karyawan/karyawan.dart';
import 'package:kita_warga_apps/model/response_expired.dart';

class KaryawanResponse {
  final List<Karyawan> karyawan;
  final String error;
  final ResponseExpired responsExpired;

  KaryawanResponse(this.karyawan, this.error, this.responsExpired);

  KaryawanResponse.fromJson(Map<String, dynamic> json)
      : karyawan =
  (json["data"] as List).map((i) => new Karyawan.fromJson(i)).toList(),
        error = "",
        responsExpired = ResponseExpired(false);

  KaryawanResponse.withError(String errorValue)
      : karyawan = [],
        error = errorValue,
        responsExpired = ResponseExpired(false);

  KaryawanResponse.with401(String errorValue)
      : karyawan = [],
        error = errorValue,
        responsExpired = ResponseExpired(true);
}