import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/warga/warga_request.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';

class WargaBloc extends Bloc<WargaRequest, AppServicesState> {
  final WargaRepository wargaRepository;
  WargaBloc({required this.wargaRepository}) : super(InitialState()) {
    on<WargaRequest>((event, emit) async {
      emit(loadingServices());
      try {
        GeneralResponsePost response = await wargaRepository.addWarga(
            WargaRequest(
                event.id_warga,
                event.nama_warga,
                event.blok_rumah,
                event.nomor_rumah,
                event.email,
                event.nomor_hp,
                event.is_rt,
                event.is_rw,
                event.id_rw,
                event.id_rt,
                event.id_perumahan,
                event.status_pernikahan,
                event.jenis_kelamin));

          emit(successServices());
          return;
      } catch (e) {
        emit(errorServices(e.toString()));
      }
    });
  }
}
