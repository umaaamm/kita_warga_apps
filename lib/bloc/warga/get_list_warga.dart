import 'package:kita_warga_apps/model/warga/get_list_warga_request.dart';
import 'package:kita_warga_apps/model/warga/list_warga_response.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListWargaBloc {
  final WargaRepository _repository = WargaRepository();
  final BehaviorSubject<ListWargaResponse> _subject =
  BehaviorSubject<ListWargaResponse>();

  getListWarga(GetListWargaRequest getListWargaRequest) async {
    ListWargaResponse response = await _repository.getListWarga(getListWargaRequest);
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<ListWargaResponse> get subject => _subject;
}

final getListWargaBloc = GetListWargaBloc();