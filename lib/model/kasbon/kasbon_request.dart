import 'package:kita_warga_apps/model/kasbon/kasbon_request_update.dart';

class KasbonRequest extends StateKasbon {
  final String id_kasbon;
  final String tanggal_transaksi;
  final String nama_karyawan;
  final String id_karyawan;
  final String detail_transaksi;
  final String pinjaman;
  final String tenor;
  final String angsuran_per_bulan;
  final String keterangan;

  KasbonRequest(
    this.id_kasbon,
    this.tanggal_transaksi,
    this.nama_karyawan,
    this.id_karyawan,
    this.detail_transaksi,
    this.pinjaman,
    this.tenor,
    this.angsuran_per_bulan,
    this.keterangan
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
