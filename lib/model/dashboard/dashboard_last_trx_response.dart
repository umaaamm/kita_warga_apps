import 'package:kita_warga_apps/model/dashboard/dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/response_expired.dart';

class DashboardLastTrxResponse {
  final List<DashboardLastTrx> dashboardLastTrx;
  final String error;
  final ResponseExpired responsExpired;

  DashboardLastTrxResponse(this.dashboardLastTrx, this.error, this.responsExpired);

  DashboardLastTrxResponse.fromJson(Map<String, dynamic> json)
      : dashboardLastTrx =
  (json["data"] as List).map((i) => new DashboardLastTrx.fromJson(i)).toList(),
        error = "",
  responsExpired = ResponseExpired(false);

  DashboardLastTrxResponse.withError(String errorValue)
      : dashboardLastTrx = [],
        error = errorValue,
        responsExpired = ResponseExpired(false);

  DashboardLastTrxResponse.with401(String errorValue)
      : dashboardLastTrx = [],
        error = errorValue,
        responsExpired = ResponseExpired(true);
}