import 'package:kita_warga_apps/model/general_response.dart';
import 'package:kita_warga_apps/model/response_expired.dart';

class GeneralResponsePost {
  final GeneralResponse generalResponse;
  final String error;
  final ResponseExpired responseExpired;

  GeneralResponsePost(this.generalResponse, this.error, this.responseExpired);

  GeneralResponsePost.fromJson(Map<String, dynamic> json)
      : generalResponse = GeneralResponse.fromJson(json),
        error = "",
  responseExpired = ResponseExpired(false);

  GeneralResponsePost.withError(String errorValue)
      : generalResponse = GeneralResponse(""),
        error = errorValue,
        responseExpired = ResponseExpired(false);

  GeneralResponsePost.with401(String errorValue)
      : generalResponse = GeneralResponse(""),
        error = errorValue,
        responseExpired = ResponseExpired(true);
}
