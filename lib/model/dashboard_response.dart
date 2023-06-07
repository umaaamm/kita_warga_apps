import 'package:kita_warga_apps/model/dashboard.dart';

class DashboardResponse {
  final Dashboard dashboard;
  final String error;

  DashboardResponse(this.dashboard, this.error);

  DashboardResponse.fromJson(Map<String, dynamic> json)
      : dashboard = Dashboard.fromJson(json),
        error = "";

  DashboardResponse.withError(String errorValue)
      : dashboard = Dashboard("","","",""),
        error = errorValue;
}