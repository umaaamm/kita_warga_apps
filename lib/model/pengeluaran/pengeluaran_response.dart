import 'package:kita_warga_apps/model/pengeluaran/pengeluaran.dart';
import 'package:kita_warga_apps/model/response_expired.dart';

class PengeluaranResponse {
  final List<Pengeluaran> pengeluaran;
  final String error;
  final ResponseExpired responsExpired;

  PengeluaranResponse(this.pengeluaran, this.error, this.responsExpired);

  PengeluaranResponse.fromJson(Map<String, dynamic> json)
      : pengeluaran =
  (json["data"] as List).map((i) => new Pengeluaran.fromJson(i)).toList(),
        error = "",
        responsExpired = ResponseExpired(false);

  PengeluaranResponse.withError(String errorValue)
      : pengeluaran = [],
        error = errorValue,
        responsExpired = ResponseExpired(false);

  PengeluaranResponse.with401(String errorValue)
      : pengeluaran = [],
        error = errorValue,
        responsExpired = ResponseExpired(true);
}