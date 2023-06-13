import 'package:equatable/equatable.dart';

class WargaRequest {
  final String id_warga;
  final String nama_warga;
  final String blok_rumah;
  final String nomor_rumah;
  final String email;
  final String nomor_hp;
  final bool is_rw;
  final bool is_rt;
  final String id_rw;
  final String id_rt;
  final String id_perumahan;
  final String status_pernikahan;
  final String jenis_kelamin;

  WargaRequest(
    this.id_warga,
    this.nama_warga,
    this.blok_rumah,
    this.nomor_rumah,
    this.email,
    this.nomor_hp,
    this.is_rw,
    this.is_rt,
    this.id_rw,
    this.id_rt,
    this.id_perumahan,
    this.status_pernikahan,
    this.jenis_kelamin,
  );
}
