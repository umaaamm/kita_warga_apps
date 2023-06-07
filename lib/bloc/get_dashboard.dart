import 'package:flutter/cupertino.dart';
import 'package:kita_warga_apps/model/dashboard_response.dart';
import 'package:kita_warga_apps/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc {
  final DashboardRepository _repository = DashboardRepository();
  final BehaviorSubject<DashboardResponse> _subject =
  BehaviorSubject<DashboardResponse>();

  getDashboard() async {
    DashboardResponse response = await _repository.getDashboardRepository();
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<DashboardResponse> get subject => _subject;
}

final dashboardBloc = DashboardBloc();