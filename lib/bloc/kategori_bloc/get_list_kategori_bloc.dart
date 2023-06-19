import 'package:kita_warga_apps/model/kategori/kategori_response.dart';
import 'package:kita_warga_apps/repository/kategori_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetListKategoriBloc {
  final KategoriRepository _repository = KategoriRepository();
  final BehaviorSubject<KategoriResponse> _subject =
  BehaviorSubject<KategoriResponse>();

  getListKategori() async {
    KategoriResponse response = await _repository.getListKategori();
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<KategoriResponse> get subject => _subject;
}

final getListKategoriBloc = GetListKategoriBloc();