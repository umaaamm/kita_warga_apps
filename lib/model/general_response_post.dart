import 'package:kita_warga_apps/model/general_response.dart';

class GeneralResponsePost {
  final GeneralResponse generalResponse;
  final String error;

  GeneralResponsePost(this.generalResponse, this.error);

  GeneralResponsePost.fromJson(Map<String, dynamic> json)
      : generalResponse = GeneralResponse.fromJson(json),
        error = "";

  GeneralResponsePost.withError(String errorValue)
      : generalResponse = GeneralResponse(""),
        error = errorValue;
}
