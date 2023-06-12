import 'package:kita_warga_apps/model/list_warga.dart';

class ListWargaResponse {
  final List<ListWarga> listWarga;
  final String error;

  ListWargaResponse(this.listWarga, this.error);

  ListWargaResponse.fromJson(Map<String, dynamic> json)
      : listWarga =
  (json["data"] as List).map((i) => new ListWarga.fromJson(i)).toList(),
        error = "";

  ListWargaResponse.withError(String errorValue)
      : listWarga = [],
        error = errorValue;
}