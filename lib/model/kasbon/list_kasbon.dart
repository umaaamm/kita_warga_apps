class ListKasbon {
  final String id_kasbon;
  final String tanggal_transaksi;
  final String nama_karyawan;
  final String id_karyawan;
  final String detail_transaksi;
  final String pinjaman;
  final String tenor;
  final String angsuran_per_bulan;
  final String keterangan;
  final String createdAt;
  final String updatedAt;
  final String posisi;
  final String sisa_kasbon;
  final String id_perumahan;
  final String nama_perumahan;
  final String alamat_perumahan;
  final String biaya_ipl;

  ListKasbon(
    this.id_kasbon,
    this.tanggal_transaksi,
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

  ListKasbon.fromJson(Map<String, dynamic> json)
      : id_kasbon = json["id_kasbon"],
        tanggal_transaksi = json["tanggal_transaksi"],
        nama_karyawan = json["nama_karyawan"],
        id_karyawan = json["id_karyawan"],
        detail_transaksi = json["detail_transaksi"],
        pinjaman = json["pinjaman"],
        tenor = json["tenor"],
        angsuran_per_bulan = json["angsuran_per_bulan"],
        id_perumahan = json["id_perumahan"],
        keterangan = json["keterangan"],
        createdAt = json["createdAt"],
        updatedAt = json["updatedAt"],
        posisi = json["posisi"],
        sisa_kasbon = json["sisa_kasbon"],
        nama_perumahan = json["nama_perumahan"],
        alamat_perumahan = json["alamat_perumahan"],
        biaya_ipl = json["biaya_ipl"];
}
