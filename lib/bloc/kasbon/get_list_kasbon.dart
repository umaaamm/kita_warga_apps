import 'package:kita_warga_apps/model/kasbon/get_list_kasbon_request.dart';
import 'package:kita_warga_apps/model/kasbon/list_kasbon_response.dart';
import 'package:kita_warga_apps/repository/kasbon_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListKasbonBloc {
  final KasbonRepository _repository = KasbonRepository();
  final BehaviorSubject<ListKasbonResponse> _subject =
  BehaviorSubject<ListKasbonResponse>();

  getListKasbon(GetListKasbonRequest getListKasbonRequest) async {
    ListKasbonResponse response = await _repository.getListKasbon(getListKasbonRequest);
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<ListKasbonResponse> get subject => _subject;
}

final getListKasbonBloc = GetListKasbonBloc();