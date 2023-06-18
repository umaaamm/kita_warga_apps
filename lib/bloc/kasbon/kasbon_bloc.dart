import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_delete_request.dart';
import 'package:kita_warga_apps/model/kasbon/kasbon_request_update.dart';
import 'package:kita_warga_apps/repository/kasbon_repository.dart';

class KasbonBloc extends Bloc<StateKasbon, AppServicesState> {
  final KasbonRepository kasbonRepository;
  KasbonBloc({required this.kasbonRepository}) : super(InitialState()) {
    // on<WargaRequest>((event, emit) => AddWarga(event, emit));
    // on<WargaRequestUpdate>((event, emit) => UpdateWarga(event, emit));
    on<KasbonDeleteRequest>((event, emit) => deleteKasbon(event, emit));
  }

  // Future AddWarga(WargaRequest event, Emitter<AppServicesState> emit) async {
  //   try {
  //     emit(loadingServices());
  //     GeneralResponsePost response = await wargaRepository.addWarga(
  //         WargaRequest(
  //             event.id_warga,
  //             event.nama_warga,
  //             event.blok_rumah,
  //             event.nomor_rumah,
  //             event.email,
  //             event.nomor_hp,
  //             event.is_rt,
  //             event.is_rw,
  //             event.id_rw,
  //             event.id_rt,
  //             event.id_perumahan,
  //             event.status_pernikahan,
  //             event.jenis_kelamin));
  //
  //     emit(successServices());
  //     return;
  //   } catch (e) {
  //     emit(errorServices(e.toString()));
  //   }
  // }

  // Future UpdateWarga(WargaRequestUpdate event, Emitter<AppServicesState> emit) async {
  //   try {
  //     emit(loadingServices());
  //     GeneralResponsePost response = await wargaRepository.updateWarga(
  //         WargaRequestUpdate(WargaRequest(
  //             event.wargaRequest.id_warga,
  //             event.wargaRequest.nama_warga,
  //             event.wargaRequest.blok_rumah,
  //             event.wargaRequest.nomor_rumah,
  //             event.wargaRequest.email,
  //             event.wargaRequest.nomor_hp,
  //             event.wargaRequest.is_rt,
  //             event.wargaRequest.is_rw,
  //             event.wargaRequest.id_rw,
  //             event.wargaRequest.id_rt,
  //             event.wargaRequest.id_perumahan,
  //             event.wargaRequest.status_pernikahan,
  //             event.wargaRequest.jenis_kelamin)));
  //
  //     emit(successServices());
  //     return;
  //   } catch (e) {
  //     emit(errorServices(e.toString()));
  //   }
  // }

  Future deleteKasbon(KasbonDeleteRequest event, Emitter<AppServicesState> emit) async {
    emit(loadingServices());
    try {
      GeneralResponsePost response = await kasbonRepository.deleteKasbon(KasbonDeleteRequest(event.id_kasbon));
      emit(successServices());
      return;
    } catch (e) {
      emit(errorServices(e.toString()));
    }
  }
}
