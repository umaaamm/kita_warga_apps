import 'package:kita_warga_apps/model/dashboard_last_trx.dart';

class DashboardLastTrxResponse {
  final List<DashboardLastTrx> dashboardLastTrx;
  final String error;

  DashboardLastTrxResponse(this.dashboardLastTrx, this.error);

  DashboardLastTrxResponse.fromJson(Map<String, dynamic> json)
      : dashboardLastTrx =
  (json["data"] as List).map((i) => new DashboardLastTrx.fromJson(i)).toList(),
        error = "";

  DashboardLastTrxResponse.withError(String errorValue)
      : dashboardLastTrx = [],
        error = errorValue;
}