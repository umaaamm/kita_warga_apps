import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_response.dart';
import 'package:kita_warga_apps/repository/pengeluaran_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListPengeluaranBloc {
  final PengeluaranRepository _repository = PengeluaranRepository();
  final BehaviorSubject<PengeluaranResponse> _subject =
      BehaviorSubject<PengeluaranResponse>();

  getListPengeluaran(GetListPengeluaranRequest getListPengeluaranRequest) async {
    PengeluaranResponse response =
        await _repository.getListPengeluaran(getListPengeluaranRequest);
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<PengeluaranResponse> get subject => _subject;
}

final getListPengeluaranBloc = GetListPengeluaranBloc();
