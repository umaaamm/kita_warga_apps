import 'package:kita_warga_apps/model/dashboard/dashboard.dart';
import 'package:kita_warga_apps/model/response_expired.dart';
import 'package:kita_warga_apps/utils/constant.dart';

class DashboardResponse {
  final Dashboard dashboard;
  final String error;
  final ResponseExpired responseExpired;

  DashboardResponse(this.dashboard, this.error, this.responseExpired);

  DashboardResponse.fromJson(Map<String, dynamic> json)
      : dashboard = Dashboard.fromJson(json),
        error = "",
        responseExpired = ResponseExpired(false);

  DashboardResponse.withError(String errorValue)
      : dashboard = Dashboard("", "", "", ""),
        error = errorValue,
        responseExpired = ResponseExpired(false);

  DashboardResponse.with401(String isExpired)
      : dashboard = Dashboard("", "", "", ""),
        error = AppConstant.msgIxpired,
        responseExpired = ResponseExpired(true);
}
