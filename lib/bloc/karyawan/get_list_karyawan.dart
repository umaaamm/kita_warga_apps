import 'package:kita_warga_apps/model/karyawan/karyawan_response.dart';
import 'package:kita_warga_apps/repository/karyawan_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListKaryawanBloc {
  final KaryawanRepository _repository = KaryawanRepository();
  final BehaviorSubject<KaryawanResponse> _subject =
  BehaviorSubject<KaryawanResponse>();

  getDashboardLastTrx() async {
    KaryawanResponse response = await _repository.getListKaryawan();
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<KaryawanResponse> get subject => _subject;
}

final getListKaryawanBloc = GetListKaryawanBloc();