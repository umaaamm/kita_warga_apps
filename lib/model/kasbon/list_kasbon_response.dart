import 'package:kita_warga_apps/model/kasbon/list_kasbon.dart';
import 'package:kita_warga_apps/model/response_expired.dart';

class ListKasbonResponse {
  final List<ListKasbon> listKasbon;
  final String error;
  final ResponseExpired isExpired;

  ListKasbonResponse(this.listKasbon, this.error, this.isExpired);

  ListKasbonResponse.fromJson(Map<String, dynamic> json)
      : listKasbon =
  (json["data"] as List).map((i) => new ListKasbon.fromJson(i)).toList(),
        error = "",
        isExpired = ResponseExpired(false);

  ListKasbonResponse.withError(String errorValue)
      : listKasbon = [],
        error = errorValue,
        isExpired = ResponseExpired(false);

  ListKasbonResponse.with401(String errorValue)
      : listKasbon = [],
        error = errorValue,
        isExpired = ResponseExpired(true);
}