import 'package:kita_warga_apps/model/kasbon/kasbon_request_update.dart';

class KasbonRequest extends StateKasbon {
  final String id_kasbon;
  final String tangggal_transaksi;
  final String nama_karyawan;
  final String id_karyawan;
  final String detail_transaksi;
  final String pinjaman;
  final bool tenor;
  final bool angsuran_per_bulan;
  final String keterangan;
  final String createdAt;
  final String updatedAt;
  final String posisi;
  final String sisa_kasbon;
  final String id_perumahan;
  final String nama_perumahan;
  final String alamat_perumahan;
  final String biaya_ipl;

  KasbonRequest(
    this.id_kasbon,
    this.tangggal_transaksi,
    this.nama_karyawan,
    this.id_karyawan,
    this.detail_transaksi,
    this.pinjaman,
    this.tenor,
    this.angsuran_per_bulan,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.posisi,
    this.sisa_kasbon,
    this.id_perumahan,
    this.nama_perumahan,
    this.alamat_perumahan,
    this.biaya_ipl,
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
