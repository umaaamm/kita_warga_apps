import 'package:kita_warga_apps/model/kategori/kategori.dart';
import 'package:kita_warga_apps/model/response_expired.dart';

class KategoriResponse {
  final List<Kategori> kategori;
  final String error;
  final ResponseExpired responsExpired;

  KategoriResponse(this.kategori, this.error, this.responsExpired);

  KategoriResponse.fromJson(Map<String, dynamic> json)
      : kategori =
  (json["data"] as List).map((i) => new Kategori.fromJson(i)).toList(),
        error = "",
        responsExpired = ResponseExpired(false);

  KategoriResponse.withError(String errorValue)
      : kategori = [],
        error = errorValue,
        responsExpired = ResponseExpired(false);

  KategoriResponse.with401(String errorValue)
      : kategori = [],
        error = errorValue,
        responsExpired = ResponseExpired(true);
}