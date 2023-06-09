import 'package:kita_warga_apps/model/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class DashboardLastTrxBloc {
  final DashboardRepository _repository = DashboardRepository();
  final BehaviorSubject<DashboardLastTrxResponse> _subject =
  BehaviorSubject<DashboardLastTrxResponse>();

  getDashboardLastTrx() async {
    DashboardLastTrxResponse response = await _repository.getDashboardLastTrxRepository();
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<DashboardLastTrxResponse> get subject => _subject;
}

final dashboardLastTrxBloc = DashboardLastTrxBloc();