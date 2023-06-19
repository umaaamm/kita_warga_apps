import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_delete_request.dart';
import 'package:kita_warga_apps/model/pengeluaran/pengeluaran_request_update.dart';
import 'package:kita_warga_apps/repository/pengeluaran_repository.dart';

import '../../model/pengeluaran/pengeluaran_request_add.dart';

class PengeluaranBloc extends Bloc<StatePengeluaran, AppServicesState> {
  final PengeluaranRepository pengeluaranRepository;
  PengeluaranBloc({required this.pengeluaranRepository})
      : super(InitialState()) {
    on<PengeluaranRequestAdd>((event, emit) => AddWarga(event, emit));
    on<PengeluaranRequestUpdate>(
        (event, emit) => UpdatePengeluaran(event, emit));
    on<PengeluaranDeleteRequest>(
        (event, emit) => deletePengeluaran(event, emit));
  }
  Future AddWarga(
      PengeluaranRequestAdd event, Emitter<AppServicesState> emit) async {
    try {
      emit(loadingServices());
      GeneralResponsePost response = await pengeluaranRepository.addPengeluaran(
          Pengeluaran(
              event.id_transaksi,
              event.nama_transaksi,
              event.id_kategori,
              event.tanggal_transaksi,
              event.nilai_transaksi,
              event.keterangan,
              event.bukti_foto,
              event.id_kasbon,
              event.kategori_transaksi));

      emit(successServices());
      return;
    } catch (e) {
      emit(errorServices(e.toString()));
    }
  }

  Future UpdatePengeluaran(
      PengeluaranRequestUpdate event, Emitter<AppServicesState> emit) async {
    try {
      emit(loadingServices());
      GeneralResponsePost response = await pengeluaranRepository
          .updatePengeluaran(PengeluaranRequestUpdate(PengeluaranRequestAdd(
              event.pengeluaranRequestAdd.id_transaksi,
              event.pengeluaranRequestAdd.nama_transaksi,
              event.pengeluaranRequestAdd.id_kategori,
              event.pengeluaranRequestAdd.tanggal_transaksi,
              event.pengeluaranRequestAdd.nilai_transaksi,
              event.pengeluaranRequestAdd.keterangan,
              event.pengeluaranRequestAdd.bukti_foto,
              event.pengeluaranRequestAdd.id_kasbon,
              event.pengeluaranRequestAdd.kategori_transaksi)));

      emit(successServices());
      return;
    } catch (e) {
      emit(errorServices(e.toString()));
    }
  }

  Future deletePengeluaran(
      PengeluaranDeleteRequest event, Emitter<AppServicesState> emit) async {
    emit(loadingServices());
    try {
      GeneralResponsePost response = await pengeluaranRepository
          .deletePengeluaran(PengeluaranDeleteRequest(event.id_transaksi));
      emit(successServices());
      return;
    } catch (e) {
      emit(errorServices(e.toString()));
    }
  }
}
