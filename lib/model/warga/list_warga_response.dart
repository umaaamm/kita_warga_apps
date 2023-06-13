import 'package:kita_warga_apps/model/response_expired.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';

class ListWargaResponse {
  final List<ListWarga> listWarga;
  final String error;
  final ResponseExpired isExpired;

  ListWargaResponse(this.listWarga, this.error, this.isExpired);

  ListWargaResponse.fromJson(Map<String, dynamic> json)
      : listWarga =
  (json["data"] as List).map((i) => new ListWarga.fromJson(i)).toList(),
        error = "",
        isExpired = ResponseExpired(false);

  ListWargaResponse.withError(String errorValue)
      : listWarga = [],
        error = errorValue,
        isExpired = ResponseExpired(false);

  ListWargaResponse.with401(String errorValue)
      : listWarga = [],
        error = errorValue,
        isExpired = ResponseExpired(true);
}